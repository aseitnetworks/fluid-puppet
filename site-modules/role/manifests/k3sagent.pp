class role::k3sagent {
  
  file { '/usr/local/bin/agent-lo-waiter.sh':
    ensure   => file,
    source   => 'puppet:///modules/role/agent-lo-waiter.sh',
    mode     => '0755',
    owner    => 'root',
    group    => 'root',
  }
  -> file { '/tmp/k3s-installer.sh':
    ensure   => file,
    source   => 'puppet:///modules/role/k3s.sh',
    mode     => '0755',
    owner    => 'root',
    group    => 'root',
  }
  -> file { '/var/log/k3saudit':
    ensure => directory,
  }
  -> exec { 'Wait for loopback address':
    command  => '/usr/local/bin/agent-lo-waiter.sh',
    user     => 'root',
    unless  => "/usr/bin/test -e /usr/local/bin/k3s",
  }
  -> exec { 'Install k3s':
    command  => '/usr/bin/sh -c "K3S_TOKEN=`cat /etc/fluid/cluster-token`; K3S_URL=`cat /etc/fluid/server-ip`; /tmp/k3s-installer.sh --node-ip=`/usr/local/bin/agent-lo-waiter.sh`"',
    user     => 'root',
    environment => ['INSTALL_K3S_CHANNEL=stable'],
    unless  => "/usr/bin/test -e /usr/local/bin/k3s",
  }
}

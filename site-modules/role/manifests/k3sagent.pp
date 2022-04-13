class role::k3sagent {     
  $nodeType = 'compute'
  
  file { '/tmp/k3s-installer.sh':
    ensure   => file,
    source   => 'puppet:///modules/role/k3s.sh',
    mode     => '0755',
    owner    => 'root',
    group    => 'root',
  }
  -> file { '/var/log/k3saudit':
    ensure => directory,
  }
  -> exec { 'Install k3s':
    command  => 'sh -c "K3S_TOKEN=`cat /etc/fluid/cluster-token`; K3S_URL=`cat /etc/fluid/server-ip`; /tmp/k3s-installer.sh"',
    user     => 'root',
    environment => ['INSTALL_K3S_CHANNEL=stable'],
    unless  => "test -e /usr/local/bin/k3s",
  }
}

class role::k3smaster {
  
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
    command  => '/usr/bin/sh -c "/tmp/k3s-installer.sh server --token-file /etc/fluid/cluster-token --server `cat /etc/fluid/server-ip` --node-ip=`/usr/local/bin/agent-lo-waiter.sh` --tls-san=`ip -4 addr show uplink | grep -oP \'(?<=inet\s)\d+(\.\d+){3}\'` --node-label fluid.aseit.com.au/nodetype=master --node-taint special=true:PreferNoSchedule --flannel-backend=none --disable-network-policy --cluster-cidr=100.65.0.0/16 --service-cidr=100.66.0.0/16 --disable=servicelb --disable=local-storage --protect-kernel-defaults --kube-apiserver-arg=enable-admission-plugins=NodeRestriction,ServiceAccount,NamespaceLifecycle --kube-apiserver-arg=feature-gates=PodSecurity=true --kube-apiserver-arg=--audit-log-path=/var/log/k3saudit/audit.log --kube-apiserver-arg=--audit-log-maxage=30 --kube-apiserver-arg=--audit-log-maxbackup=10 --kube-apiserver-arg=--audit-log-maxsize=100 --kube-apiserver-arg=--service-account-lookup=true"',
    user     => 'root',
    environment => ['INSTALL_K3S_CHANNEL=stable'],
    unless  => "/usr/bin/test -e /usr/local/bin/k3s",
  }
}

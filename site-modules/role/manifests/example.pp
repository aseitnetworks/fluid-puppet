class role::example {     
  $nodeType = 'switchmaster'         
    file { '/tmp/k3s-installer.sh':
        ensure   => present,
        source   => 'https://get.k3s.io/',
        mode     => '0755',
        owner    => 'root',
        group    => 'root',
    }
    ->
    exec { 'Install k3s':
        command  => '/tmp/k3s-installer.sh server --cluster-init --node-label fluid.aseit.com.au/nodetype=$nodeType --node-taint special=true:PreferNoSchedule --flannel-backend=none --disable-network-policy --cluster-cidr=100.65.0.0/16 --service-cidr=100.66.0.0/16 --disable=servicelb --disable=local-storage --protect-kernel-defaults --kube-apiserver-arg=enable-admission-plugins=NodeRestriction,ServiceAccount,NamespaceLifecycle --kube-apiserver-arg=feature-gates=PodSecurity=true --kube-apiserver-arg=--audit-log-path=/var/log/k3saudit/audit.log --kube-apiserver-arg=--audit-log-maxage=30 --kube-apiserver-arg=--audit-log-maxbackup=10 --kube-apiserver-arg=--audit-log-maxsize=100 --kube-apiserver-arg=--service-account-lookup=true',
        user     => 'root',
        environment => ['INSTALL_K3S_CHANNEL=stable'],
    }
}

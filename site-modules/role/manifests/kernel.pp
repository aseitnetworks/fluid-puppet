class role::kernel {     
  file { '/etc/sysctl.d/90-kubelet.conf':
    ensure   => file,
    source   => 'puppet:///modules/role/90-kubelet.conf',
    mode     => '0644',
    owner    => 'root',
    group    => 'root',
  }
  -> exec { 'Set kernel params':
    command  => 'sysctl -p /etc/sysctl.d/90-kubelet.conf',
    user     => 'root',
  }
}

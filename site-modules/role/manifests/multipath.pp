class role::multipath {     
  file { '/etc/multipath.conf':
    ensure   => file,
    source   => 'puppet:///modules/role/multipath.conf',
    mode     => '0644',
    owner    => 'root',
    group    => 'root',
  }
  -> exec { 'Restart multipathd':
    command  => '/usr/bin/systemctl restart multipathd.service',
    user     => 'root',
  }
}

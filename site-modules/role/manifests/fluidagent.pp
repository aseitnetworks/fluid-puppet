class role::fluidagent {     
  $releaseType = 'stable'
  
  file { '/etc/apt/sources.list.d/internal.list':
    ensure   => file,
    content  => 'deb https://apt.fluid.aseit.com.au/ $releaseType main',
    mode     => '0644',
    owner    => 'root',
    group    => 'root',
  }
  -> exec { 'Install agent':
    command  => 'sh -c "apt-get update && apt-get install -y fluid-agent"',
    user     => 'root',
    unless  => "test -e /usr/bin/fluid-agent",
  }
}

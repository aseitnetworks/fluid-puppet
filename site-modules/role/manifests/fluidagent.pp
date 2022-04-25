class role::fluidagent { 
  file { '/etc/apt/sources.list.d/fluid.list':
    ensure   => file,
    content  => 'deb https://apt.fluid.aseit.com.au/ unstable main',
    mode     => '0644',
    owner    => 'root',
    group    => 'root',
  }
  -> exec { 'Install fluid gpt key':
    command  => '/usr/bin/sh -c "wget -qO - https://apt.fluid.aseit.com.au/public.key | apt-key add -"',
    user     => 'root',
    unless  => "/usr/bin/test -e /usr/bin/fluid-agent",
  }
  -> exec { 'Install agent':
    command  => '/usr/bin/sh -c "apt-get update && apt-get install -y fluid-agent"',
    user     => 'root',
    unless  => "/usr/bin/test -e /usr/bin/fluid-agent",
  }
}

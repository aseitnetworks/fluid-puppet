## site.pp ##

File { backup => false }

node default {
}

node /^fluid-master.*$/ {
  include role::fluidagent
  include role::kernel
  include role::k3smaster
}

node /^fluid-agent.*$/ {
  include role::fluidagent
  include role::kernel
  include role::k3sagent
}

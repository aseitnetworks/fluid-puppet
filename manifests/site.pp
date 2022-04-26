## site.pp ##

File { backup => false }

node default {
  include role::kernel
  include role::multipath
}

node /^fluid-master.*$/ {
  include role::fluidagent
  include role::k3smaster
}

node /^fluid-agent.*$/ {
  include role::fluidagent
  include role::k3sagent
}

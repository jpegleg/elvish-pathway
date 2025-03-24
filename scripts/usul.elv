#!/usr/bin/env elvish

var sessionid = (uidgen)
var worm = (which wormsign)

echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - We found $worm and will use it.
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - SHA256 checksum of wormsign: (sha256sum $worm)
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - reading targets from ./worm.json

var wormtargets = (from-json < worm.json)

echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - checking on $@wormtargets

peach {|h|
  var y = (echo $h[target] | sha256sum | cut -c1-32)
  mkdir -p /opt/wormsign/live/$y
  cd /opt/wormsign/live/$y/
  cp /opt/wormsign/templates/wormsign.toml__template /opt/wormsign/live/$y/wormsign.toml
  /bin/bash /home/unseenwork/workspace/elvish-pathway/scripts/update_config.sh $y $h[target] /opt/wormsign/live/$y/wormsign.toml
  var logstamp = (date +%Y-%m-%dT%H:%M:%SZ)
  echo $logstamp - $sessionid - $h[target] - signed
} $wormtargets

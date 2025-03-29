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
  /bin/bash /opt/wormsign/templates/check.sh /opt/wormsign/live/$y
  var logstamp = (date +%Y-%m-%dT%H:%M:%SZ)
  echo $logstamp - $sessionid - $h[target] - checked
} $wormtargets

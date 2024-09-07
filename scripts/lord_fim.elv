#!/usr/bin/env elvish

var sessionid = (uidgen)
var fms = (which fms)

echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - We found $fms and will use it.
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - SHA256 checksum of fms: (sha256sum $fms)
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - reading targets from ./fim.json

var fimtargets  =  (from-json < fim.json)

mkdir -p /opt/fimsyscheck/live /opt/fimsyscheck/previous 2>/dev/null
echo (date +%Y-%m-%dT%H:%M:%SZ) - $sessionid - checking on $@fimtargets

peach {|h|
  var y = (echo $h[target] | sha256sum | cut -c1-32).json
  touch /opt/fimsyscheck/live/$y
  cp /opt/fimsyscheck/live/$y /opt/fimsyscheck/previous/$y
  fms $h[target] > /opt/fimsyscheck/live/$y
  var logstamp = (date +%Y-%m-%dT%H:%M:%SZ)
  logger $logstamp - $sessionid - $h[target] - new report: (cat /opt/fimsyscheck/live/$y)
  logger $logstamp - $sessionid - $h[target] - old report: (cat /opt/fimsyscheck/previous/$y)
  echo $logstamp - $sessionid - $h[target] - sent logger data
} $fimtargets

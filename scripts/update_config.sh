#!/usr/bin/env bash
sed -i "s|TEMPLATE|$1|g" "$3" &&
sed -i "s|TPATH|$2|g" "$3" &&
sleep 1 && # reduces chances of failed signs... try to optimize this
/usr/local/bin/wormsign -ats > sign.json &&
/usr/local/bin/wormsign -v > verify.json

#!/usr/bin/env bash
sed -i "s|TEMPLATE|$1|g" "$3"
sed -i "s|TPATH|$2|g" "$3"
/usr/local/bin/wormsign -ats > sign.json 2>/dev/null
/usr/local/bin/wormsign -v > verify.json 2>/dev/null

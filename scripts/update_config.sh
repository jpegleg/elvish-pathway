#!/usr/bin/env bash
cd "$5" &&
sleep 0.2 &&
/usr/local/bin/wormsign-confgen "$1" "$2" "$3" "$4" &&
sleep 0.2 &&
/usr/local/bin/wormsign -ats > sign.json &&
/usr/local/bin/wormsign -v > verify.json

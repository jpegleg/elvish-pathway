#!/usr/bin/env bash
cd "$1" &&
sleep 0.2 &&
/usr/local/bin/wormsign -av > check.json

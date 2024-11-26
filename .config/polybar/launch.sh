#!/usr/bin/env bash

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar | tee -a /tmp/polybar1.log & disown

echo "Bars launched.."

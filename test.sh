#!/bin/bash

nginx -g "daemon on;"

printf "%-8s %-20s %-8s %-22s %-20s\n" "Case #" "Test URL" '$host' '$request_uri' '$uri'

idx=0
for domain in {1..8} a b c d; do
  idx=$((idx+1))
  path=$(printf "/test%02d/abc/test" $idx)
  printf "  %02d     %-20s %-8s %-22s %-20s\n" $idx $path $(curl -s -H "Host: $domain.com" -I "http://127.0.0.1$path" | grep 'X-URI' | grep -oE " .+")
done
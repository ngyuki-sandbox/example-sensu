#!/bin/bash

urls=(
  http://rvtgd827ews64.ngrok.io/
  http://qiita.com/ngyuki
)

if [[ "$#" -eq 0 ]]; then
  no=0
  for url in "${urls[@]}"; do
    : $((no++))
    "$0" "$url" "$no" &
  done
  wait
  exit
fi

url=$1
no=$2
name=$url

name=${name#http://}
name=${name#https://}
name=${name%%/*}

output=$(set -o pipefail; curl -ifsS "$url" 2>&1 | sed -n 1p)
status=$?

if [[ $status -ne 0 ]]; then
  status=2
fi

jq -n --arg source "external" --arg name "$name" --arg output "$output" --arg status "$status" '{
    source: $source,
    name: $name,
    output: $output,
    status: $status | tonumber,
}' > /dev/tcp/localhost/3030

echo "$name: ($status) $output"

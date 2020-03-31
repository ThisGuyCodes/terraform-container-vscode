#!/bin/bash
set -eu

echo "----BEGIN----"
terraform validate -json |
    jq --raw-output -f ./scripts/tf_filter.jq
echo "----END----"

inotifywait \
    --monitor \
    --recursive \
    --includei '.*\.tf' \
    @.terraform \
    --csv \
    --event close_write \
    --event move \
    --event create \
    --event delete \
    . |
    while read line; do
        echo "----BEGIN----"
        terraform validate -json |
            jq --raw-output -f ./scripts/tf_filter.jq
        echo "----END----"
    done

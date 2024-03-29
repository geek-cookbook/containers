#!/usr/bin/env bash

channel=$1

if [[ "${channel}" == "laster13" ]]; then
    version=$(curl -sX GET "https://api.github.com/repos/laster13/rdt-client/commits/master" --header "Authorization: Bearer ${TOKEN}" | jq --raw-output '.sha')
else
    version=$(curl -sX GET https://api.github.com/repos/rogerfar/rdt-client/releases/latest --header "Authorization: Bearer ${TOKEN}" | jq --raw-output '. | .tag_name')
fi

printf "%s" "${version}"

#!/bin/bash
#/usr/bin/env bash

shopt -s extglob
shopt -s extquote
# shopt -s xpg_echo

set -f

# Usage: bash ./zcash-rpc-req.sh "http://zcash.rpc.server.domain:port" "user:rpc.auth.key" getblock (hash | height) [0..2]

declare -rx server_def='mainnet.z.cash'
declare -rx server=${1:-$server_def}
declare -rx auth_def='andrcmdr'
declare -rx auth=${2:-$auth_def}
declare -rx request_def='getblock'
declare -rx request=${3:-$reqest_def}

if [[ "${@}" == "" || "${1}" == "help" || "${1}" == "--help" || "${1}" == "h" || "${1}" == "-h" ]]; then
    echo -e 'Usage: bash ./zcash-rpc-req.sh "http://zcash.rpc.server.domain:port" "user:rpc.auth.key" getblock (hash | height) [0..2]'
elif [[ "${request}" == "getblockhash" ]]; then
    curl -vi --user "${auth}" --data-binary '{"jsonrpc": "1.0", "id":"curl", "method": "getblockhash", "params": ['"${4}"'] }' -H 'content-type: text/plain;' "${server}" 2>/dev/null
elif [[ "${request}" == "getblockhashes" ]]; then
    curl -vi --user "${auth}" --data-binary '{"jsonrpc": "1.0", "id":"curl", "method": "getblockhashes", "params": ['"${4}"', '"${5}"', {"noOrphans":false, "logicalTimes":true}] }' -H 'content-type: text/plain;' "${server}" 2>/dev/null
elif [[ "${request}" == "getblockheader" ]]; then
    curl -vi --user "${auth}" --data-binary '{"jsonrpc": "1.0", "id":"curl", "method": "getblockheader", "params": ["'"${4}"'", true] }' -H 'content-type: text/plain;' "${server}" 2>/dev/null
elif [[ "${request}" == "getblock" ]]; then
    curl -vi --user "${auth}" --data-binary '{"jsonrpc": "1.0", "id":"curl", "method": "getblock", "params": ["'"${4}"'", '"${5}"'] }' -H 'content-type: text/plain;' "${server}" 2>/dev/null
fi


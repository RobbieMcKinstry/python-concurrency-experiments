#!/usr/bin/env bash

# This script will run all Pulumi experiments.
# It uses Hyperfine to run all of the experiemnts sequentially.
set -exuo pipefail

readonly WARMUP_RUNS="0"
readonly SAMPLE_SIZE="1"
readonly EXPERIMENTS="control,1,8,16,32"
readonly RESOURCE_COUNT="4,200,10000"

function main {
  hyperfine \
    --warmup="${WARMUP_RUNS}" \
    --runs="${SAMPLE_SIZE}" \
    --parameter-list "group" "${EXPERIMENTS}" \
    --parameter-list "resources" "${RESOURCE_COUNT}" \
    --prepare="./scripts/s3-concurrency/prepare.bash {group}" \
    --cleanup="./scripts/s3-concurrency/cleanup.bash {group}" \
    --show-output \
    --export-json "s3-concurrency.json" \
    "./scripts/s3-concurrency/up.bash {group} {resources}"
}

main
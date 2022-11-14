#!/usr/bin/env bash

set -exuo pipefail

# Select the correct Pulumi binary.
readonly PULUMI_EXEC="${HOME}/.pulumi-dev/bin/pulumi"
readonly WORKSPACE="${HOME}/workspace/pulumi/pulumi"
readonly GROUP="$1"
readonly RESOURCE_COUNT="$2"

function run_project {
  # Ensure no variables from previous experiments are set.
  unset PULUMI_CONFIG_PASSPHRASE
  unset PULUMI_EXPERIMENTAL
  unset PULUMI_SKIP_CHECKPOINTS
  unset PULUMI_OPTIMIZED_CHECKPOINT_PATCH
  unset CONCURRENCY_MULTIPLIER
  
  export RESOURCE_COUNT

  PROJECT_DIR="s3-concurrency"

  if [ "${GROUP}" == "control" ]
  then
    export CONCURRENCY_MULTIPLIER="0"
  else
    export CONCURRENCY_MULTIPLIER="${GROUP}"
  fi
  

  pushd $(pwd)
  
  cd "${PROJECT_DIR}"
  echo "Collecting a sample for ${GROUP}."
  "${PULUMI_EXEC}" up --yes --non-interactive --stack=dev --skip-preview

  popd
}

function main {
  run_project
}

main
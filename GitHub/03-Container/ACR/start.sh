#!/bin/bash
set -e

if [ -z "$GHRP_URL" ]; then
  echo 1>&2 "error: missing GHRP_URL environment variable"
  exit 1
fi

if [ -z "$GHRP_TOKEN_FILE" ]; then
  if [ -z "$GHRP_TOKEN" ]; then
    echo 1>&2 "error: missing GHRP_TOKEN environment variable"
    exit 1
  fi

  GHRP_TOKEN_FILE=/GHRP/.token
  echo -n $GHRP_TOKEN > "$GHRP_TOKEN_FILE"
fi

unset GHRP_TOKEN

if [ -n "$GHRP_WORK" ]; then
  mkdir -p "$GHRP_WORK"
fi

export RUNNER_ALLOW_RUNASROOT="1"

cleanup() {
  if [ -e config.sh ]; then
    print_header "Cleanup. Removing GitHub Actions RUNNER..."

    # If the RUNNER has some running jobs, the configuration removal process will fail.
    # So, give it some time to finish the job.
    while true; do
      ./config.sh remove --unattended --token $(cat "$GHRP_TOKEN_FILE") && break

      echo "Retrying in 30 seconds..."
      sleep 30
    done
  fi
}

print_header() {
  lightcyan='\033[1;36m'
  nocolor='\033[0m'
  echo -e "${lightcyan}$1${nocolor}"
}

# Let the RUNNER ignore the token env variables
export VSO_RUNNER_IGNORE=GHRP_TOKEN,GHRP_TOKEN_FILE

source ./env.sh

print_header "1. Configuring GitHub Actions RUNNER..."

./config.sh --unattended \
  --name "${GHRP_RUNNER_NAME:-$(hostname)}" \
  --url "$GHRP_URL" \
  --token $(cat "$GHRP_TOKEN_FILE") \
  --work "${GHRP_WORK:-_work}" \
  --replace & wait $!

print_header "2. Running GitHub Actions RUNNER..."

trap 'cleanup; exit 0' EXIT
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

# To be aware of TERM and INT signals call run.sh
# Running it with the --once flag at the end will shut down the RUNNER after the build is executed
./run.sh "$@" &

wait $!
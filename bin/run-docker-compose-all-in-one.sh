#!/bin/bash
SCRIPT_DIR=$(cd $(dirname $0) && pwd)
source ${SCRIPT_DIR}/app.env
YML_FILE="${SCRIPT_DIR}/yml/docker-compose.yml"
docker-compose -f $YML_FILE $*

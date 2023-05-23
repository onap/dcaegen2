#!/bin/bash

# ===========LICENSE_START========================================================
# ================================================================================
# Copyright (c) 2017 AT&T Intellectual Property. All rights reserved.
# ================================================================================
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============LICENSE_END=========================================================
#
# ECOMP is a trademark and service mark of AT&T Intellectual Property.

set -ex


echo "running script: [$0] for module [$1] at stage [$2]"

MVN_PROJECT_MODULEID="$1"
MVN_PHASE="$2"
PROJECT_ROOT=$(dirname $0)

# expected environment variables
if [ -z "${MVN_NEXUSPROXY}" ]; then
    echo "MVN_NEXUSPROXY environment variable not set.  Cannot proceed"
    exit 1
fi
if [ -z "$SETTINGS_FILE" ]; then
    echo "SETTINGS_FILE environment variable not set.  Cannot proceed"
    exit 2
fi




source "${PROJECT_ROOT}"/mvn-phase-lib.sh 


# Customize the section below for each project
case $MVN_PHASE in
clean)
  echo "==> clean phase script"
  clean_templated_files
  clean_tox_files
  rm -rf ./venv-* ./*.wgn ./site
  ;;
generate-sources)
  echo "==> generate-sources phase script"
  expand_templates
  ;;
compile)
  echo "==> compile phase script"
  ;;
test)
  echo "==> test phase script"
  ;;
package)
  echo "==> package phase script"
  ;;
install)
  echo "==> install phase script"
  ;;
deploy)
  echo "==> deploy phase script"
  case $MVN_PROJECT_MODULEID in
  platformdoc)
    set -x
    CURDIR=$(pwd)
    virtualenv ./venv-doc
    source ./venv-doc/bin/activate
    pip install --no-cache-dir --upgrade pip
    pip install --no-cache-dir --upgrade 'mkdocs==0.16.3' mkdocs-material
    pip freeze

    mkdocs build
    build_and_push_docker
    deactivate
    rm -rf ./venv-doc

    # build docker image from Docker file (under module dir) and push to registry
    build_and_push_docker
    ;;
  *)
    echo "====> unknown mvn project module"
    ;;
  esac
  ;;
*)
  echo "==> unprocessed phase"
  ;;
esac


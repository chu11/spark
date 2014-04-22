#!/usr/bin/env bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Usage: start-slave.sh <worker#> <master-spark-URL>
#   where <master-spark-URL> is like "spark://localhost:7077"

sbin=`dirname "$0"`
sbin=`cd "$sbin"; pwd`

# Check if --config is passed as an argument. It is an optional parameter.
# Exit if the argument is not a directory.

if [ "$1" == "--config" ]
then
  shift
  conf_dir=$1
  if [ ! -d "$conf_dir" ]
  then
    echo "ERROR : $conf_dir is not a directory"
    echo $usage
    exit 1
  else
    export SPARK_CONF_DIR=$conf_dir
  fi
  shift
fi

if [ "${SPARK_CONF_DIR}X" != "X" ]
then
    "$sbin"/spark-daemon.sh --config $SPARK_CONF_DIR start org.apache.spark.deploy.worker.Worker "$@"
else
    "$sbin"/spark-daemon.sh start org.apache.spark.deploy.worker.Worker "$@"
fi

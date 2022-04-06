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

## 环境变量:
## SPARK_HOME
## MLSQL_HOME
##

export MLSQL_HOME=/data/dep/byzer/jsdu/mlsql-engine_2.4-2.3.0-SNAPSHOT
export SPARK_HOME=/opt/cloudera/parcels/CDH/lib/spark

set -u
set -e
set -o pipefail

for env in SPARK_HOME ; do
  if [ -z "${!env}" ]; then
    echo "$env must be set to run this script"
    exit 1
  fi
done

## 本脚本部署在${MLSQL_HOME}/bin 目录
if [ -z "${MLSQL_HOME}" ]; then
  export MLSQL_HOME="$(cd "`dirname "$0"`"/..; pwd)"
  echo "MLSQL_HOME is not set, default to ${MLSQL_HOME}"
fi

JARS=$(echo ${MLSQL_HOME}/libs/*.jar | tr ' ' ',')
MAIN_JAR=$(ls ${MLSQL_HOME}/libs|grep 'streamingpro-mlsql')
export DRIVER_MEMORY=${DRIVER_MEMORY:-2g}

echo
echo "#############"
echo "Run with spark : $SPARK_HOME"
echo "With DRIVER_MEMORY=${DRIVER_MEMORY:-2g}"
echo
echo "JARS: ${JARS}"
echo "MAIN_JAR: ${MLSQL_HOME}/libs/${MAIN_JAR}"
echo "#############"
echo
echo
echo
sleep 5

$SPARK_HOME/bin/spark-submit --class streaming.core.StreamingApp \
        --driver-memory ${DRIVER_MEMORY} \
        --jars ${JARS} \
        --name mlsql \
        --conf "spark.sql.hive.thriftServer.singleSession=true" \
        --conf "spark.kryoserializer.buffer=256k" \
        --conf "spark.kryoserializer.buffer.max=1024m" \
        --conf "spark.serializer=org.apache.spark.serializer.KryoSerializer" \
        --conf "spark.scheduler.mode=FAIR" \
        --conf "spark.executor.extraClassPath=/opt/cloudera/parcels/CDH/jars/spark-lineage_2.11-2.4.0-cdh6.3.2.jar" \
        --conf "spark.driver.extraClassPath=/opt/cloudera/parcels/CDH/jars/spark-lineage_2.11-2.4.0-cdh6.3.2.jar" \
        ${MLSQL_HOME}/libs/${MAIN_JAR}    \
        -streaming.name mlsql    \
        -streaming.platform spark   \
        -streaming.rest true   \
        -streaming.driver.port 9003   \
        -streaming.spark.service true \
        -streaming.thrift false \
        -streaming.enableHiveSupport false \
        --driver-java-options -verbose:class \
        -streaming.datalake.path ${MLSQL_HOME}/datalake \
        -streaming.spark.service true  \
        -streaming.job.cancel true \
        --files ${MLSQL_HOME}/conf/log4j.properties \
        --master yarn \
        --deploy-mode client \
        --num-executors 10 \
        --executor-memory 1G \
        --executor-cores 2

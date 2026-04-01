REGION=us-east4
SQL_INSTANCE_NAME=sp26-hive-metastore
CLUSTER_NAME=etudo-hive-cluster-v3-sp26

gcloud sql instances patch ${SQL_INSTANCE_NAME} \
--activation-policy=ALWAYS

gcloud dataproc clusters start ${CLUSTER_NAME} \
--region=${REGION}
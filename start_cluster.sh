REGION=us-east4
DB_INSTANCE_NAME=hive-metastor-sp25
CLUSTER_NAME=etudo-hive-cluster-v4-sp25

gcloud sql instances patch ${DB_INSTANCE_NAME} \
--activation-policy=ALWAYS

gcloud dataproc clusters start ${CLUSTER_NAME} \
--region=${REGION}
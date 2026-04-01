REGION=
SQL_INSTANCE_NAME=
CLUSTER_NAME=

gcloud sql instances patch ${SQL_INSTANCE_NAME} \
--activation-policy=ALWAYS

gcloud dataproc clusters start ${CLUSTER_NAME} \
--region=${REGION}
REGION=
SQL_INSTANCE_NAME=
CLUSTER_NAME=

gcloud sql instances patch ${SQL_INSTANCE_NAME} \
--activation-policy=NEVER

gcloud dataproc clusters stop ${CLUSTER_NAME} \
--region=${REGION}
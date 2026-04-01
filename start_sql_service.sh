REGION=us-east4
DB_INSTANCE_NAME=sp26-hive-metastore

gcloud sql instances patch ${DB_INSTANCE_NAME} \
--activation-policy=ALWAYS

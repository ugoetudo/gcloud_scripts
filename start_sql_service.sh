REGION=
DB_INSTANCE_NAME=

gcloud sql instances patch ${DB_INSTANCE_NAME} \
--activation-policy=ALWAYS

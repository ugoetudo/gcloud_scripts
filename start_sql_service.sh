REGION=us-east4
DB_INSTANCE_NAME=hive-metastor-sp25

gcloud sql instances patch ${DB_INSTANCE_NAME} \
--activation-policy=ALWAYS

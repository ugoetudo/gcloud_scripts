# CREATE HIVE CLUSTER SCRIPT
# See Details Below:
# *** https://github.com/GoogleCloudDataproc/initialization-actions/blob/main/cloud-sql-proxy/README.md
# If the script fails, be sure to use Cloud Console to check that no VMs were created. 
# If any VM exists (regardless of whether it has an error status) delete the cluster.

# DECLARE VARIABLES
HIVE_DATA_BUCKET=
PROJECT_ID=
REGION=us-east4
SQL_INSTANCE_NAME=
CLUSTER_NAME=
SECRETS_BUCKET=
KEYRING=
KMS_KEY=
KEY_URI=projects/${PROJECT_ID}/locations/global/keyRings/${KEYRING}/cryptoKeys/${KMS_KEY}
# BUILD GCLOUD DATAPROC CREATE CLUSTER COMMAND
# Note directives begin with --metadata and --properties...  what do you think these are doing?
gcloud dataproc clusters create ${CLUSTER_NAME} \
--region ${REGION} \
--image-version=2.0-ubuntu18 \
--master-machine-type n1-standard-2 \
--master-boot-disk-size 100 \
--num-workers 2 \
--worker-machine-type n1-standard-2 \
--worker-boot-disk-size 100  \
--scopes cloud-platform \
--initialization-actions gs://goog-dataproc-initialization-actions-${REGION}/cloud-sql-proxy/cloud-sql-proxy.sh \
--properties "hive:hive.metastore.warehouse.dir=gs://${HIVE_DATA_BUCKET}/hive-warehouse" \
--metadata "hive-metastore-instance=${PROJECT_ID}:${REGION}:${SQL_INSTANCE_NAME}" \
--metadata "enable-cloud-sql-proxy-on-workers=false" \
--metadata "kms-key-uri=${KEY_URI}" \
--metadata "db-admin-password-uri=gs://${SECRETS_BUCKET}/hive-admin-password.encrypted" \
--metadata "db-hive-password-uri=gs://${SECRETS_BUCKET}/hive-password.encrypted"

# note that the last two metadata flags assume that you've named your encrypted password files 
# for db root (admin) and for the hive db user hive-admin-password.encrypted and 
# hive-password.encrypted, respectively
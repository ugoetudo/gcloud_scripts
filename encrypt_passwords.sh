echo "Ent3r_the_metastore" | gcloud kms encrypt \
--location=global \
--keyring=etudo-bda-keyring \
--key=hive-db-key-v1 \
--plaintext-file=- \
--ciphertext-file=hive-password.encrypted
echo "W00ble\$R00ble\$" | gcloud kms encrypt \
--location=global \
--keyring=etudo-bda-keyring \
--key=hive-db-key-v1 \
--plaintext-file=- \
--ciphertext-file=hive-admin-password.encrypted
gcloud storage cp *.encrypted gs://etudo-bda-keys/
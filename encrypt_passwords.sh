echo "Ent3r_the_metastore" | gcloud kms encrypt \
--location=global \
--keyring=etudo-bda-keyring \
--key=hive-db-key-v1 \
--plaintext-file=- \
--ciphertext-file=hive-password.encrypted
echo "your password here" | gcloud kms encrypt \
--location=global \
--keyring=etudo-bda-keyring \
--key=hive-db-key-v1 \
--plaintext-file=- \
--ciphertext-file=hive-admin-password.encrypted
gcloud storage cp *.encrypted gs://your-bucket-of-keys/

# please take note of the file names in the --ciphertext-file flags above
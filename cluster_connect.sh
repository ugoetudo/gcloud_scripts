ZONE=us-east4-b
PROJECT=opim-big-data-analytics
CLUSTER_VM_NAME=etudo-hive-cluster-v3-sp26-m

gcloud compute ssh ${CLUSTER_VM_NAME} \
--zone=${ZONE} \
--project=${PROJECT} 
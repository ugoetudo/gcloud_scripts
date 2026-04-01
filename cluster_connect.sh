ZONE=
PROJECT=
CLUSTER_VM_NAME=

gcloud compute ssh ${CLUSTER_VM_NAME} \
--zone=${ZONE} \
--project=${PROJECT} 
# Run this file with 
# chmod +x deploy_epc_pipeline.sh 
# ./deploy_epc_pipeline.sh


#!/usr/bin/env bash
set -e

export GCP_PROJECT_ID="sincere-amulet-507008-j2"
export FIRESTORE_DATABASE_ID="epcfirestoredb"

gcloud run deploy epc-pipeline-service \
  --source . \
  --region us-east1 \
  --service-account epc-platform-agent@sincere-amulet-507008-j2.iam.gserviceaccount.com \
  --allow-unauthenticated \
  --set-env-vars GCP_PROJECT_ID="$GCP_PROJECT_ID",FIRESTORE_DATABASE_ID="$FIRESTORE_DATABASE_ID"

if [ $? -ne 0 ]; then
  echo "Deployment failed."
  exit 1
fi

echo "Deployment command completed successfully."

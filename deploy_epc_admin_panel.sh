#!/usr/bin/env bash
set -e

# Ensure Google Cloud SDK is on PATH even in non-login shells
export PATH="/home/codespace/google-cloud-sdk/bin:$PATH"

# Run this file with:
# chmod +x deploy_epc_admin_panel.sh
# ./deploy_epc_admin_panel.sh

export GCP_PROJECT_ID="sincere-amulet-507008-j2"
export FIRESTORE_DATABASE_ID="epcfirestoredb"

if ! command -v gcloud >/dev/null 2>&1; then
  echo "gcloud not found. Please ensure Google Cloud SDK is installed."
  exit 1
fi

gcloud run deploy epc-admin-panel \
  --source . \
  --region us-east1 \
  --service-account epc-platform-agent@sincere-amulet-507008-j2.iam.gserviceaccount.com \
  --allow-unauthenticated \
  --set-env-vars GCP_PROJECT_ID="$GCP_PROJECT_ID",FIRESTORE_DATABASE_ID="$FIRESTORE_DATABASE_ID"

echo "Deployment command completed successfully."

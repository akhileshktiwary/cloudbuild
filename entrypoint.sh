#!/bin/bash
set -e

echo "Authenticating with GCP..."
gcloud auth activate-service-account --key-file=/secrets/service-account.json
gcloud config set project sap-tso-dev-mg

echo "Running terraformer import..."
terraformer import google --resources=sql --projects=sap-tso-dev-mg --regions=us-central1

echo "Import finished!"

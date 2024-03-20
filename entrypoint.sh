#!/bin/bash

cd /github/workspace/backend; npm install;
cd /github/workspace;
touch /github/workspace/backend/.env;
echo CLIENT_ID="${CLIENT_ID}" >> /github/workspace/backend/.env;
echo CLIENT_SECRET="${CLIENT_SECRET}" >> /github/workspace/backend/.env;
echo REDIRECT_URL="${REDIRECT_URL}" >> /github/workspace/backend/.env;
echo REDIRECT_URL_2="${REDIRECT_URL_2}" >> /github/workspace/backend/.env;
echo ENDPOINT="${ENDPOINT}" >> /github/workspace/backend/.env;
echo TOPIC_NAME="${TOPIC_NAME}" >> /github/workspace/backend/.env;
echo SUBSCRIPTION_NAME="${SUBSCRIPTION_NAME}" >> /github/workspace/backend/.env;
echo MEILISEARCH_URL="${MEILISEARCH_URL}" >> /github/workspace/backend/.env;
echo MEILISEARCH_KEY="${MEILISEARCH_KEY}" >> /github/workspace/backend/.env;
echo MEILISEARCH_API_KEY="${MEILISEARCH_API_KEY}" >> /github/workspace/backend/.env;
echo MEILISEARCH_UUID="${MEILISEARCH_UUID}" >> /github/workspace/backend/.env;
echo REDIRECT_URL_BROWSER="${REDIRECT_URL_BROWSER}" >> /github/workspace/backend/.env;
echo REDIRECT_URL_BROWSER_2="${REDIRECT_URL_BROWSER_2}" >> /github/workspace/backend/.env;
echo TASKMIDDLEWARE_URL="${TASKMIDDLEWARE_URL}" >> /github/workspace/backend/.env;
echo FIRESTORE_CERT="${FIRESTORE_CERT}" >> /github/workspace/backend/.env;
echo ENVIRONMENT="${ENVIRONMENT}" >> /github/workspace/backend/.env;
cat /github/workspace/backend/.env;

if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

firebase deploy \
    -m "${GITHUB_REF} (${GITHUB_SHA})" \
    --project ${FIREBASE_PROJECT} \
    --only functions:groupA,groupB --force

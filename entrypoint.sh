#!/bin/bash

cd /github/workspace/backend; npm install;
cd /github/workspace;
touch /github/workspace/.env;
echo FIREBASE_TOKEN="${FIREBASE_TOKEN}" >> /github/workspace/.env;
echo GOOGLE_APPLICATION_CREDENTIALS="${GOOGLE_APPLICATION_CREDENTIALS}" >> /github/workspace/.env;
echo CLIENT_ID="${CLIENT_ID}" >> /github/workspace/.env;
echo CLIENT_SECRET="${CLIENT_SECRET}" >> /github/workspace/.env;
echo REDIRECT_URL="${REDIRECT_URL}" >> /github/workspace/.env;
echo REDIRECT_URL_2="${REDIRECT_URL_2}" >> /github/workspace/.env;
echo ENDPOINT="${ENDPOINT}" >> /github/workspace/.env;
echo TOPIC_NAME="${TOPIC_NAME}" >> /github/workspace/.env;
echo SUBSCRIPTION_NAME="${SUBSCRIPTION_NAME}" >> /github/workspace/.env;
echo MEILISEARCH_URL="${MEILISEARCH_URL}" >> /github/workspace/.env;
echo MEILISEARCH_KEY="${MEILISEARCH_KEY}" >> /github/workspace/.env;
echo MEILISEARCH_API_KEY="${MEILISEARCH_API_KEY}" >> /github/workspace/.env;
echo MEILISEARCH_UUID="${MEILISEARCH_UUID}" >> /github/workspace/.env;
echo REDIRECT_URL_BROWSER="${REDIRECT_URL_BROWSER}" >> /github/workspace/.env;
echo REDIRECT_URL_BROWSER_2="${REDIRECT_URL_BROWSER_2}" >> /github/workspace/.env;
echo TASKMIDDLEWARE_URL="${TASKMIDDLEWARE_URL}" >> /github/workspace/.env;
echo FIRESTORE_CERT=${FIRESTORE_CERT} >> /github/workspace/.env;
echo FIREBASE_PROJECT="${FIREBASE_PROJECT}" >> /github/workspace/.env;
echo ENVIRONMENT="${ENVIRONMENT}" >> /github/workspace/.env;
cat /github/workspace/.env;

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
    --only functions

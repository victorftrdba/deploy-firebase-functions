#!/bin/bash

cd /github/workspace/backend; npm install;
cd /github/workspace;

touch /github/workspace/.env;
echo FIREBASE_TOKEN=${FIREBASE_TOKEN_DEV} | tee -a /github/workspace/.env;
echo GOOGLE_APPLICATION_CREDENTIALS=${GOOGLE_APPLICATION_CREDENTIALS_DEV} | tee -a /github/workspace/.env;
echo CLIENT_ID=${CLIENT_ID_DEV} | tee -a /github/workspace/.env;
echo CLIENT_SECRET=${CLIENT_SECRET_DEV} | tee -a /github/workspace/.env;
echo REDIRECT_URL=${REDIRECT_URL_DEV} | tee -a /github/workspace/.env;
echo REDIRECT_URL_2=${REDIRECT_URL_2_DEV} | tee -a /github/workspace/.env;
echo ENDPOINT=${ENDPOINT_DEV} | tee -a /github/workspace/.env;
echo TOPIC_NAME=${TOPIC_NAME_DEV} | tee -a /github/workspace/.env;
echo SUBSCRIPTION_NAME=${SUBSCRIPTION_NAME_DEV} | tee -a /github/workspace/.env;
echo MEILISEARCH_URL=${MEILISEARCH_URL_DEV} | tee -a /github/workspace/.env;
echo MEILISEARCH_KEY=${MEILISEARCH_KEY_DEV} | tee -a /github/workspace/.env;
echo MEILISEARCH_API_KEY=${MEILISEARCH_API_KEY_DEV} | tee -a /github/workspace/.env;
echo MEILISEARCH_UUID=${MEILISEARCH_UUID_DEV} | tee -a /github/workspace/.env;
echo REDIRECT_URL_BROWSER=${REDIRECT_URL_BROWSER_DEV} | tee -a /github/workspace/.env;
echo REDIRECT_URL_BROWSER_2=${REDIRECT_URL_BROWSER_2_DEV} | tee -a /github/workspace/.env;
echo TASKMIDDLEWARE_URL=${TASKMIDDLEWARE_URL_DEV} | tee -a /github/workspace/.env;
echo FIRESTORE_CERT=${FIRESTORE_CERT_DEV} | tee -a /github/workspace/.env;
echo FIREBASE_PROJECT=${FIREBASE_PROJECT} | tee -a /github/workspace/.env;
echo ENVIRONMENT=${ENVIRONMENT} | tee -a /github/workspace/.env;
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

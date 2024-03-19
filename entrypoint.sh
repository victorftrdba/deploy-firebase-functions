#!/bin/bash

cd /github/workspace/backend; npm install;
cd /github/workspace;

mkdir /github/workspace/config/pruvo-test-v2-creds.json;
echo ${FIRESTORE_CERT} >> /github/workspace/config/pruvo-test-v2-creds.json;
cat /github/workspace/config/pruvo-test-v2-creds.json;

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

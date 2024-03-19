#!/bin/bash

cd applications; npm install; npm run build; cd /github/workspace
cd auth; npm install; npm run build; cd /github/workspace
cd backend; npm install; npm run build; cd /github/workspace
cd cancel-application; npm install; npm run build; cd /github/workspace
cd classroom-roster-change; npm install; npm run build; cd /github/workspace
cd competency-matrices; npm install; npm run build; cd /github/workspace
cd create-application; npm install; npm run build; cd /github/workspace
cd jobs; npm install; npm run build; cd /github/workspace
cd pubsub; npm install; npm run build; cd /github/workspace
cd tasks; npm install; npm run build; cd /github/workspace
cd users; npm install; npm run build; cd /github/workspace

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

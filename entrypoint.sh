#!/bin/bash

cd applications; npm install; npm run build
cd ..
cd auth; npm install; npm run build
cd ..
cd backend; npm install; npm run build
cd ..
cd cancel-application; npm install; npm run build
cd ..
cd classroom-roster-change; npm install; npm run build
cd ..
cd competency-matrices; npm install; npm run build
cd ..
cd create-application; npm install; npm run build
cd ..
cd jobs; npm install; npm run build
cd ..
cd pubsub; npm install; npm run build
cd ..
cd tasks; npm install; npm run build
cd ..
cd users; npm install; npm run build
cd ..

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

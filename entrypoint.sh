#!/bin/bash

cd applications; npm install
cd auth; npm install
cd backend; npm install
cd cancel-application; npm install
cd classroom-roster-change; npm install
cd competency-matrices; npm install
cd create-application; npm install
cd jobs; npm install
cd pubsub; npm install
cd tasks; npm install
cd users; npm install

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

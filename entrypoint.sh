#!/bin/bash

cd /github/workspace/applications; npm install;
cd /github/workspace/auth; npm install;
cd /github/workspace/backend; npm install;
cd /github/workspace/cancel-application; npm install;
cd /github/workspace/classroom-roster-change; npm install;
cd /github/workspace/competency-matrices; npm install;
cd /github/workspace/create-application; npm install;
cd /github/workspace/jobs; npm install;
cd /github/workspace/pubsub; npm install;
cd /github/workspace/tasks; npm install;
cd /github/workspace/users; npm install;
cd /github/workspace;

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

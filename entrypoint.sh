#!/bin/bash

# Verifica se FIREBASE_TOKEN está definido
if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

# Verifica se FIREBASE_PROJECT está definido
if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

# Lista das pastas desejadas
folders=(
    "/github/workspace/applications"
    "/github/workspace/auth"
    "/github/workspace/backend"
    "/github/workspace/cancel-application"
    "/github/workspace/classroom-roster-change"
    "/github/workspace/competency-matrices"
    "/github/workspace/create-application"
    "/github/workspace/jobs"
    "/github/workspace/pubsub"
    "/github/workspace/sync-meilisearch"
    "/github/workspace/tasks"
    "/github/workspace/users"
)

# Loop sobre cada pasta
for folder in "${folders[@]}"
do
    # Navega para a pasta
    cd $folder;
    
    # Instalação do npm
    npm install;
    
    # Criação do arquivo .env e atribuição de variáveis
    touch .env;
    
    # Escrita das variáveis no .env
    echo CLIENT_ID="${CLIENT_ID}" >> .env;
    echo CLIENT_SECRET="${CLIENT_SECRET}" >> .env;
    echo REDIRECT_URL="${REDIRECT_URL}" >> .env;
    echo REDIRECT_URL_2="${REDIRECT_URL_2}" >> .env;
    echo ENDPOINT="${ENDPOINT}" >> .env;
    echo TOPIC_NAME="${TOPIC_NAME}" >> .env;
    echo SUBSCRIPTION_NAME="${SUBSCRIPTION_NAME}" >> .env;
    echo MEILISEARCH_URL="${MEILISEARCH_URL}" >> .env;
    echo MEILISEARCH_KEY="${MEILISEARCH_KEY}" >> .env;
    echo MEILISEARCH_API_KEY="${MEILISEARCH_API_KEY}" >> .env;
    echo MEILISEARCH_UUID="${MEILISEARCH_UUID}" >> .env;
    echo REDIRECT_URL_BROWSER="${REDIRECT_URL_BROWSER}" >> .env;
    echo REDIRECT_URL_BROWSER_2="${REDIRECT_URL_BROWSER_2}" >> .env;
    echo TASKMIDDLEWARE_URL="${TASKMIDDLEWARE_URL}" >> .env;
    echo FIRESTORE_CERT="${FIRESTORE_CERT}" >> .env;
    echo ENVIRONMENT="${ENVIRONMENT}" >> .env;

    # Exibe o conteúdo do .env
    cat .env;

    # Lista dos arquivos de grupo
    groupFiles=(
        "./src/group-applications-a.ts"
        "./src/group-auth-a.ts"
        "./src/group-backend-a.ts"
        "./src/group-backend-b.ts"
        "./src/group-cancel-application-a.ts"
        "./src/group-classroom-roster-change-a.ts"
        "./src/group-competency-matrices-a.ts"
        "./src/group-create-application-a.ts"
        "./src/group-jobs-a.ts"
        "./src/group-pubsub-a.ts"
        "./src/group-sync-meilisearch-a.ts"
        "./src/group-tasks-a.ts"
        "./src/group-users-a.ts"
    )
    groupNames=(
        "groupApplicationsA"
        "groupAuthA"
        "groupBackendA"
        "groupBackendB"
        "groupCancelApplicationA"
        "groupClassroomRosterChangeA"
        "groupCompetencyMatricesA"
        "groupCreateApplicationA"
        "groupJobsA"
        "groupPubsubA"
        "groupSyncMeilisearchA"
        "groupTasksA"
        "groupUsersA"
    )

    for (( i = 0; i < ${#groupFiles[@]}; i++ )); do
        # Verifica se o arquivo existe
        # e inicia implantação pelo
        # nome do grupo
        if [ -f "${groupFiles[i]}" ]; then
            firebase deploy \
                -m "${GITHUB_REF} (${GITHUB_SHA})" \
                --project "${FIREBASE_PROJECT}" \
                --only "functions:${groupNames[i]}" \
                --force
        fi
    done
done

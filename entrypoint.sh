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
    cd "$folder";
    
    # Instalação do npm
    npm install;
    
    # Criação do arquivo .env e atribuição de variáveis
    touch "${folder}/.env";
    
    # Escrita das variáveis no .env
    echo CLIENT_ID="${CLIENT_ID}" >> "${folder}/.env";
    echo CLIENT_SECRET="${CLIENT_SECRET}" >> "${folder}/.env";
    echo REDIRECT_URL="${REDIRECT_URL}" >> "${folder}/.env";
    echo REDIRECT_URL_2="${REDIRECT_URL_2}" >> "${folder}/.env";
    echo ENDPOINT="${ENDPOINT}" >> "${folder}/.env";
    echo TOPIC_NAME="${TOPIC_NAME}" >> "${folder}/.env";
    echo SUBSCRIPTION_NAME="${SUBSCRIPTION_NAME}" >> "${folder}/.env";
    echo MEILISEARCH_URL="${MEILISEARCH_URL}" >> "${folder}/.env";
    echo MEILISEARCH_KEY="${MEILISEARCH_KEY}" >> "${folder}/.env";
    echo MEILISEARCH_API_KEY="${MEILISEARCH_API_KEY}" >> "${folder}/.env";
    echo MEILISEARCH_UUID="${MEILISEARCH_UUID}" >> "${folder}/.env";
    echo REDIRECT_URL_BROWSER="${REDIRECT_URL_BROWSER}" >> "${folder}/.env";
    echo REDIRECT_URL_BROWSER_2="${REDIRECT_URL_BROWSER_2}" >> "${folder}/.env";
    echo TASKMIDDLEWARE_URL="${TASKMIDDLEWARE_URL}" >> "${folder}/.env";
    echo FIRESTORE_CERT="${FIRESTORE_CERT}" >> "${folder}/.env";
    echo ENVIRONMENT="${ENVIRONMENT}" >> "${folder}/.env";

    # Exibe o conteúdo do .env
    cat "${folder}/.env";

    # Lista dos arquivos de grupo
    groupFiles=(
        "group-a.ts"
        "group-b.ts"
        "group-c.ts"
        "group-d.ts"
    )

    # Loop sobre cada arquivo para verificar se existe
    # e iniciar processo de implantação
    for groupFile in "${groupFiles[@]}"
    do
        # Verifica se o arquivo existe
        if [ -f "${groupFile}" ]; then
            firebase deploy \
                -m "${GITHUB_REF} (${GITHUB_SHA})" \
                --project "${FIREBASE_PROJECT}" \
                --only "functions:${groupFile}.ts" \
                --force
        fi
    done
done

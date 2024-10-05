#!/bin/bash

# Get mnemonic phrase from user
read -p "Enter your mnemonic phrase: " mnemonic_phrase

mkdir hugging-allora
cd hugging-allora
git clone https://github.com/allora-network/allora-huggingface-walkthrough.git
cd allora-huggingface-walkthrough
mkdir worker-data
touch worker-data/env_file
chmod -R 777 worker-data
rm docker-compose.yaml

cat << EOF > docker-compose.yaml
services:
  hugging-inference:
    container_name: hugging-inference
    build:
      context: .
      dockerfile: Dockerfile
    command: python -u /app/app.py
    ports:
      - "8008:8008"

  hugging-worker:
    container_name: hugging-worker
    image: alloranetwork/allora-offchain-node:latest
    volumes:
      - ./worker-data:/data
    depends_on:
      - hugging-inference
    env_file:
      - ./worker-data/env_file
  
volumes:
  inference-data:
  worker-data:
EOF


# Write the JSON content to config.json
cat <<EOF > config.json
{
    "wallet": {
        "addressKeyName": "test",
        "addressRestoreMnemonic": "$mnemonic_phrase",
        "alloraHomeDir": "",
        "gas": "1000000",
        "gasAdjustment": 1.2,
        "nodeRpc": "https://rpc.ankr.com/allora_testnet",
        "maxRetries": 2,
        "delay": 1,
        "submitTx": true
    },
    "worker": [
        {
            "topicId": 1,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "ETH"
            }
        },
        {
            "topicId": 2,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "ETH"
            }
        },
        {
            "topicId": 3,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "BTC"
            }
        },
        {
            "topicId": 4,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "BTC"
            }
        },
        {
            "topicId": 5,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "SOL"
            }
        },
        {
            "topicId": 6,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "SOL"
            }
        },
        {
            "topicId": 7,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "ETH"
            }
        },
        {
            "topicId": 8,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "BNB"
            }
        },
        {
            "topicId": 9,
            "inferenceEntrypointName": "api-worker-reputer",
            "loopSeconds": 60,
            "parameters": {
                "InferenceEndpoint": "http://hugging-inference:8008/inference/{Token}",
                "Token": "ARB"
            }
        }
        
    ]
}
EOF

chmod +x init.config
./init.config 

# Run docker containers
docker-compose up -d

#!/bin/bash

# Login to Azure CLI
az login --service-principal \
    --username "4d1befd9-6e67-47bd-9f37-5346876c61dd" \
    --password "[REDACTED SECRET]" \
    --tenant "27027724-9428-4baa-8029-74929c6c7841"

# Set Azure subscription
az account set --subscription "27027724-9428-4baa-8029-74929c6c7841"

# Create resource group if it doesn't exist
az group create --name "ai-foundry-workshop" --location "eastus"

# Install Azure AI CLI extension if not already installed
az extension add -n ai

# Create Azure AI resource if it doesn't exist
az ai resource create \
    --name "drug-discovery" \
    --resource-group "ai-foundry-workshop" \
    --location "eastus" \
    --sku "S0"

# Create Azure AI project if it doesn't exist
az ai project create \
    --name "drug-discovery" \
    --resource "drug-discovery" \
    --resource-group "ai-foundry-workshop" \
    --location "eastus"

# Export Azure credentials with spn_4o_ prefix
export spn_4o_AZURE_CLIENT_ID="4d1befd9-6e67-47bd-9f37-5346876c61dd"
export spn_4o_AZURE_CLIENT_SECRET="[REDACTED SECRET]"
export spn_4o_AZURE_TENANT_ID="27027724-9428-4baa-8029-74929c6c7841"
export spn_4o_AZURE_SUBSCRIPTION_ID="27027724-9428-4baa-8029-74929c6c7841"

# Set required environment variables for main.py
export AZURE_CLIENT_ID="4d1befd9-6e67-47bd-9f37-5346876c61dd"
export AZURE_CLIENT_SECRET="[REDACTED SECRET]"
export AZURE_TENANT_ID="27027724-9428-4baa-8029-74929c6c7841"
export PROJECT_CONNECTION_STRING="https://gk-oai.openai.azure.com/"
export MODEL_DEPLOYMENT_NAME="gpt-4"

# Export Azure AI configuration
export spn_4o_azure_endpoint="https://drug-discovery.cognitiveservices.azure.com"
export spn_4o_model="gpt-4"
export spn_4o_api_version="2024-02-15-preview"

# Export Bing API key for grounding tool
export spn_4o_BING_API_KEY="804499684f0f4223b1e5c4eb05c12b8e"

# Set Azure AI Projects configuration
export AZURE_AI_PROJECT_ENDPOINT="https://drug-discovery.cognitiveservices.azure.com"
export AZURE_AI_PROJECT_KEY="[REDACTED SECRET]"

# Set resource identifiers
export AZURE_RESOURCE_GROUP="ai-foundry-workshop"
export AZURE_PROJECT_NAME="drug-discovery"
export AZURE_REGION="eastus"  # Add region for resource creation

# Set API configuration
export spn_4o_api_version="2024-02-15-preview"
export ENABLE_PREVIEW_FEATURES="true"

# Set deployment configuration
export MODEL_DEPLOYMENT_NAME="gpt-4"
export DEPLOYMENT_NAME="drug-discovery"
export DEPLOYMENT_MODEL="gpt-4"

# Set Azure AI Projects configuration
export spn_4o_AZURE_PROJECT_ENDPOINT="https://gk-oai.openai.azure.com/"
export spn_4o_AZURE_PROJECT_KEY="[REDACTED SECRET]"
export spn_4o_AZURE_RESOURCE_GROUP="ai-foundry-workshop"
export spn_4o_AZURE_PROJECT_NAME="drug-discovery"

# Enable test mode and set test configuration
export TEST_MODE="true"
export JWT_SECRET_KEY="test-jwt-secret-key-for-development-only"

echo "Environment variables set for testing:"
echo "Azure Client ID: ${AZURE_CLIENT_ID:0:5}..."
echo "Azure Client Secret: ${AZURE_CLIENT_SECRET:0:5}..."
echo "Azure Tenant ID: ${AZURE_TENANT_ID:0:5}..."
echo "Project Connection String: ${PROJECT_CONNECTION_STRING}"
echo "Model Deployment: ${MODEL_DEPLOYMENT_NAME}"

echo "Environment variables set for testing:"
echo "Azure Client ID: ${spn_4o_AZURE_CLIENT_ID:0:5}..."
echo "Azure Client Secret: ${spn_4o_AZURE_CLIENT_SECRET:0:5}..."
echo "Azure Tenant ID: ${spn_4o_AZURE_TENANT_ID:0:5}..."
echo "Azure Endpoint: ${spn_4o_azure_endpoint:0:20}..."
echo "Model Deployment: ${MODEL_DEPLOYMENT_NAME}"
echo "API Version: 2024-08-01-preview"
echo "Bing API Key: ${spn_4o_BING_API_KEY:0:5}..."

#Requisites
#   az cli
#   azure subscription

#Setup Subscription ID
az account set --subscription=xxxxxxxxxxxxxxxxxxxxxxxxxxxxx

#Create SP for Terraform
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#Create Terraform Backend
#RG = Resource Group // ST = Storage Account // CNT = Container
RG_NAME=rg-terraform-unir
ST_ACCOUNT_NAME=stterraformtfstate$RANDOM
CNT_NAME=tfstate
LOCATION="UK South"

# Resource Group
az group create --name $RG_NAME --location "$LOCATION"

# Storage Account
az storage account create --resource-group $RG_NAME --name $ST_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Key
ST_ACCOUNT_KEY=$(az storage account keys list --resource-group $RG_NAME --account-name $ST_ACCOUNT_NAME --query [0].value -o tsv)

# Blob Container
az storage container create --name $CNT_NAME --account-name $ST_ACCOUNT_NAME --account-key $ST_ACCOUNT_KEY

# Get Details
echo "storage_account_name: $ST_ACCOUNT_NAME"
echo "container_name: $CNT_NAME"
echo "access_key: $ST_ACCOUNT_KEY"
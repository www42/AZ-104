import pulumi
import pulumi_azure_native as azure_native

# 1. install Pulumi on your system
# 2. create a pulumi project and a stack
# 3. log in with "az login" and choose a subscription with permissions to contribute
# 4. create a storage account with blob container by using "pulumi up"
# read stack configuration
config = pulumi.Config()


# Create an Azure Resource Group
resource_group = azure_native.resources.ResourceGroup(
    resource_name="rg-gwc-account-dev",
)

# Create an Azure resource (Storage Account)
account = azure_native.storage.StorageAccount(
    "stagwcaccountdev",
    account_name="stagwcaccountdev",
    resource_group_name=resource_group.name,
    sku={
        "name": azure_native.storage.SkuName.STANDARD_LRS,
    },
    kind=azure_native.storage.Kind.STORAGE_V2,
    opts=pulumi.ResourceOptions(
        depends_on=[resource_group]
    ),
)

# Create an Azure Blob Storage
blob_container = azure_native.storage.BlobContainer(
    "stcgwccontainerdev",
    resource_group_name=resource_group.name,
    account_name=account.name,
    opts=pulumi.ResourceOptions(
        depends_on=[account]
    )
)
 
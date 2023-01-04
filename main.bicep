@minLength(3)
@maxLength(24)
@description('provide a name for the storage account. use only lower case letters and numbers. The name must be unique across Azure')
param storageName string

param vnetName string

param location string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetName
  location:  location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'Subnet-1'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
      {
        name: 'Subnet-2'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
    ]
  }
}


resource exampleStorage 'Microsoft.Storage/storageAccounts@2022-09-01'= {
  name: storageName
#disable-next-line no-hardcoded-location
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}


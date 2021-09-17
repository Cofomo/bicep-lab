
resource stg 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: stAccName 
  location: region
  kind: 'StorageV2' // super! on a l'intellisense ici grace a l'extension bicep pour vs code !
  sku: {
    name: 'Standard_LRS' // quand on ne sait pas quelles sont les proprietes possibles, il suffit de faire CTRL+. pour activer l'intellisense
  }
}

param region string = 'canadacentral'



@minLength(3)
@maxLength(17)
param nomProjet string 



var stAccName = '${nomProjet}store'


output stgConnStr string = stg.properties.primaryEndpoints.web

output blobStorageConnectionString string = 'DefaultEndpointsProtocol=https;AccountName=${stg.name};EndpointSuffix=${environment().suffixes.storage};AccountKey=${listKeys(stg.id, stg.apiVersion).keys[0].value}'

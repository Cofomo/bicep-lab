targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param pAppname string = 'default-appservice'

@allowed([
  'canadaeast'
  'canadacentral'
])
param pLocation string
param pServerFarmId string
var webSiteName = 'demo-${pAppname}-appservice-${uniqueString(resourceGroup().id)}'

resource website 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName // Nom du app serivce unique global
  location: pLocation
  properties: {
    serverFarmId: pServerFarmId
    httpsOnly: true
  }
}
output webSiteName string = webSiteName

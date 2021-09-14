targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param pAppServicename string = 'default-appservice'

@allowed([
  'canadaeast'
  'canadacentral'
])
param pLocation string  

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: pAppServicename// nom du app serivce plan
  location: pLocation // Azure Region
  sku: {
    name: 'B1'
    capacity: 1
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: 'demo-bicep-webapp' // Nom du app serivce unique global
  location: pLocation
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

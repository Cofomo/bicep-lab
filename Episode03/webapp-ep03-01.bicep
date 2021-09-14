targetScope = 'resourceGroup'


resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: 'demo-bicep-appserviceplan' // nom du app serivce plan
  location: 'canadacentral' // Azure Region
  sku: {
    name: 'B1'
    capacity: 1
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: 'demo-bicep-webapp'  // Nom du app serivce unique global
  location: 'canadacentral'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

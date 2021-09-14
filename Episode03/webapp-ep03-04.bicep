targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param pAppname string = 'default-appservice'

@allowed([
  'canadaeast'
  'canadacentral'
])
param pLocation string

var appServicePlanName = 'demo-${pAppname}-appserviceplan'
var webSiteName = 'demo-${pAppname}-appservice-${uniqueString(resourceGroup().id)}'
//demo-demobicep-appservice-4yucyqepd4rpc

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName// nom du app serivce plan
  location: resourceGroup().location // même Azure Region que le ResourceGroup 
  sku: {
    name: 'B1'
    capacity: 1
  }
}

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName // Nom du app serivce unique global
  location: pLocation
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

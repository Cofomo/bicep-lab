
targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param pAppname string = 'default-appservice'

@allowed([
  'canadaeast'
  'canadacentral'
])
param pLocation string

param pSkuName string

param pCapacity int

param pHttpsOnly bool


var appServicePlanName = 'demo-${pAppname}-appserviceplan'
var webSiteName = 'demo-${pAppname}-appservice-${uniqueString(resourceGroup().id)}'


resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName// nom du app serivce plan
  location: resourceGroup().location // même Azure Region que le ResourceGroup 
  sku: {
    name: pSkuName
    capacity: pCapacity
  }
}

resource webApp 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName // Nom du app serivce unique global
  location: pLocation
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: pHttpsOnly
  }
}

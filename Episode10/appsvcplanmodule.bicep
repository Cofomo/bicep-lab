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

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName// nom du app serivce plan
  location: pLocation 
  sku: {
    name: 'B1'
    capacity: 1
  }
}
output appServicePlanName string = appServicePlanName
output appServicePlanID string = appServicePlan.id 

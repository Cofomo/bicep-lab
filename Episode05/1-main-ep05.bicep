targetScope = 'resourceGroup'

param LaLocation string = 'canadacentral'
param LeAppname string = 'DemoModule'

module appServicePlan '2-appservice-ep05.bicep' = {
  name: 'appServicePlan'
  params: {
    pLocation: LaLocation
    pAppname: LeAppname
  }
}

module webApp '3-webapp-ep05.bicep' = {
  name: 'webApp'
  params: {
    pLocation: LaLocation
    pAppname: LeAppname
    pServerFarmId : appServicePlan.outputs.appServicePlanID
  }
}
// Le main pourrait avoir aussi des output...

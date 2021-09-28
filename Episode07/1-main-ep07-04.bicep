targetScope = 'subscription'

param LaLocation string = 'canadacentral'
param resourceGroupsNames array 

module rg '4-rg-ep07.bicep' = [for resourceGroupsName in resourceGroupsNames:{
  name: 'asbDeploy-${resourceGroupsName}'
  params: {
    location: LaLocation
    resourceGroupsName: resourceGroupsName
  }
}]

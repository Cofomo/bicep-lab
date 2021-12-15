targetScope = 'subscription'

param LaLocation string = 'canadacentral'
param resourceGroupsName string = 'runatcloud-demobicep05-rg'

module rg '4-rg-ep07.bicep' = [for i in range(1,4):{
  name: 'rgDeploy${i}'
  params: {
    location: LaLocation
    resourceGroupsName: '${resourceGroupsName}${i}'
  }
}]

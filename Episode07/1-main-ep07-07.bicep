targetScope = 'subscription'

param LaLocation string = 'canadacentral'
param resourceGroupsName string = 'runatcloud-demobicep07-rg'

@batchSize(2)
module rg '4-rg-ep07.bicep' = [for i in range(1,3):{
  name: 'rgDeploy${i}'
  params: {
    location: LaLocation
    resourceGroupsName: '${resourceGroupsName}${i}'
  }
}]

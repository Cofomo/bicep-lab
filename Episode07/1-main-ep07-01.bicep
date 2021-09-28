targetScope = 'subscription'

param LaLocation string = 'canadacentral'

param deployerRG bool = false
param resourceGroupsName string = 'runatcloud-demobicep01-rg'

module rg '4-rg-ep07.bicep' = if (deployerRG){
  name: 'asbDeploy'
  params: {
    location: LaLocation
    resourceGroupsName: resourceGroupsName
  }
}

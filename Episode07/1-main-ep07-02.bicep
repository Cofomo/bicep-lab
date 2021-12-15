targetScope = 'subscription'

param LaLocation string = 'canadacentral'
param resourceGroupsName string = 'runatcloud-demobicep02-rg'

module rg '4-rg-ep07.bicep' = if (resourceGroupsName!='runatcloud-demobicep02-rg'){
  name: 'asbDeploy'
  params: {
    location: LaLocation
    resourceGroupsName: resourceGroupsName
  }
}

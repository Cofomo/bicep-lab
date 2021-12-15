targetScope = 'subscription'

param LaLocation string = 'canadacentral'

param resourceGroupsName string = 'runatcloud-demobicep03-rg'
param environnement string = 'prod'
var NomRGparEnv  = (environnement == 'prod' ? resourceGroupsName : '${environnement}-${resourceGroupsName}')

module rg '4-rg-ep07.bicep' = {
  name: 'asbDeploy'
  params: {
    location: LaLocation
    resourceGroupsName: NomRGparEnv
  }
}

// az deployment sub create --name resourcegroups --template-file "resourcegroups.bicep" --location "Canada Central" --parameters parameters.resourcegroups.json  --subscription "xxxx-yyyy-zzzz"
targetScope = 'subscription'

param resourceGroupsName string
param location string
param appname string


module rg 'rg.bicep' = {
  name: 'asbDeploy'
  params: {
    location: location
    resourceGroupsName: resourceGroupsName
  }
}

module webapp 'webapp.bicep' = {
  name: 'webappDeploy'
  scope: resourceGroup(resourceGroupsName)
  params: {
    location: rg.outputs.rgLocation
    appname: appname
  }
}

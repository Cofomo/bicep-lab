targetScope = 'subscription'

param resourceGroupsName string
param location string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupsName
  location: location
  tags: {}
  properties: {}
}

output rgLocation string = rg.location

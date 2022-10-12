
@description('Web app name.')
@minLength(2)
param webAppName string = 'webApp-${uniqueString(resourceGroup().id)}'


@description('Location for all resources.')
param location string = resourceGroup().location


@description('Describes plan\'s pricing tier and instance size.')
@allowed([
  'F1'
  'D1'
  'B1'
])
param sku string = 'F1'


var appServicePlanName = 'AppServicePlan-${webAppName}'


resource asp 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
  }
}


resource webApp 'Microsoft.Web/sites@2021-03-01' = {
 name: webAppName
 location: location
 identity: {
   type: 'SystemAssigned'
 }
properties: {
  siteConfig: {
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
  }
  serverFarmId: asp.id
  httpsOnly: true
  }
}

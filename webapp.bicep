targetScope = 'resourceGroup'

param location string 
param appname string

var appServicePlanName = 'demo-${appname}-appserviceplan'
var webSiteName = 'demo-${appname}-appservice'

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName // app serivce plan name
  location: location // Azure Region
  sku: {
    name: 'B1'
    capacity: 1
  }
  tags: {
    displayName: 'HostingPlan'
    ProjectName: appname
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName // Globally unique app serivce name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  tags: {
    displayName: 'Website'
    ProjectName: appname
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      minTlsVersion: '1.2'
    }
  }

  resource symbolicname 'config' = {
    name: 'appsettings'
    properties: {
      PROJET: 'demo bicep'
    }
  }

}



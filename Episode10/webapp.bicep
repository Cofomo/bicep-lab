targetScope = 'resourceGroup'

@minLength(3)
@maxLength(24)
param pAppname string = 'default-appservice'

@allowed([
  'canadaeast'
  'canadacentral'
])
param pLocation string
param pNomPlan string

var webSiteName = 'demo-${pAppname}-appservice-${uniqueString(resourceGroup().id)}' // Nom du app serivce unique global

// c'est ici que la référence se fait !
// Lorsqu’on ajoute la référence au module sur le registre dans le code, si VS Code n’arrive pas à obtenir le module (car il n’existe pas ou par manque de permissions), le message d’erreur approprié apparaitra.
// Une fois le code compilé, et si on inspecte le json qui en résulte, on remarquera qu’on y retrouve le contenu du module importé.
module appServicePlan 'br:runatcloudcr.azurecr.io/bicep/modules/appsvcplan:v1' = {
  name: 'appServicePlan'
  params: {
    pLocation: pLocation
    pAppname: pNomPlan
  }
}


resource website 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName 
  location: pLocation
  properties: {
    serverFarmId: appServicePlan.outputs.appServicePlanID
    httpsOnly: true
  }
}
output webSiteName string = webSiteName

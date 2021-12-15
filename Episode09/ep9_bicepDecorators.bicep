

@description('La région dans laquelle déployer les ressources')
param location string


@allowed([
  'dev'
  'accept'
  'prod'
])
param environmentType string


@minLength(3)
@maxLength(13)
param resourceNameSuffix string


@minValue(4)
@maxValue(32)
param quantiteRam int


@secure()
param sqlAdminPassword string


@metadata({
  description: 'Le nom de l’application ou du système logiciel' 
  versionModele: '2021-12-11'
})
param applicationName string



// on ne fait pas de déploiement dans cet exemple, juste un affichage.
// pour cela, il nous faut définir des outputs
output region string = location
output environnement string = environmentType
output qteMemoire int = quantiteRam
output suffixe string = resourceNameSuffix
output motDePasse string = sqlAdminPassword
output appName string = applicationName

param sqlServerDetails array = [
  {
    name: 'sqlserver-we'
    location: 'westeurope'
    environmentName: 'Production'
  }
  {
    name: 'sqlserver-eus2'
    location: 'eastus2'
    environmentName: 'Development'
  }
]

resource sqlServers 'Microsoft.Sql/servers@2020-11-01-preview' = [for sqlServer in sqlServerDetails: if (sqlServer.environmentName == 'Production') {
  name: sqlServer.name
  location: sqlServer.location
  properties: {
    administratorLogin: 'adminexemple'
    administratorLoginPassword: 'motdepassequinedevraitpasetredanslecodemaisquiproviendraitdunekeyvault'
  }
  tags: {
    environment: sqlServer.environmentName
  }
}]

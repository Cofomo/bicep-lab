Param(
    [string] [Parameter(Mandatory=$true)] $ResourceGroupName,
    [string] [Parameter(Mandatory=$true)] $ServiceBusName,
    [string] [Parameter(Mandatory=$true)] $DataFilePath,
    [string] $TenantId,
	[string] $SubscriptionId,
	[string] $ServicePrincipalId,
	[string] $ServicePrincipalKey,
	[string] $SkipConnection = 'N'
)


# Connection Azure
if ($SkipConnection -eq 'N'){
	$securePassword = ConvertTo-SecureString $ServicePrincipalKey -AsPlainText -Force
	$psCredential = New-Object System.Management.Automation.PSCredential ($ServicePrincipalId, $securePassword)
	Connect-AzureRmAccount -ServicePrincipal -Credential $psCredential -Tenant $TenantId
	Set-AzureRmContext -Subscription $SubscriptionId
}

# Charger les paramètres de tests (expected):
$Expected = Import-PowerShellDataFile -Path $DataFilePath


# Obtenir les ressources Azure à tester
$rg = Get-AzResourceGroup -ResourceGroupName $ResourceGroupName
$sbNamespace = Get-AzServiceBusNamespace -ResourceGroupName $ResourceGroupName -Name $ServiceBusName
$sbQueues = Get-AzServiceBusQueue -ResourceGroupName $ResourceGroupName -Namespace $ServiceBusName


# Définir les tests

###############  Tests du Groupe de ressources ###############
Describe 'Validation du groupe de ressources' {
    It "Le nom du groupe de ressources est correct" {
      $rg.ResourceGroupName | Should -Be $Expected.ResourceGroup.Name
    }
    It "L'emplacement (la région) du groupe de ressources est correct" {
      $rg.Location | Should -Be $Expected.ResourceGroup.Location
    }
}

###############  Tests de l'espace de noms du service bus ###############
Describe 'Validation de l''espace de noms du service bus' {
    It "Le ServiceBus se trouve dans le bon RG" {
        $sbNamespace.ResourceGroupName | Should -Be $Expected.ServiceBusNamespace.ResourceGroupName
    }
    It "Le ServiceBus a le bon nom" {
        $sbNamespace.Name | Should -Be $Expected.ServiceBusNamespace.Name
    }
    It "Le ServiceBus est dans la bonne région (Location)" {
        $sbNamespace.Location | Should -Be $Expected.ServiceBusNamespace.Location
    }
    # It "Le Sku du ServiceBus est correct" {        
    #     $sbNamespace.Sku.Name.ToString() | Should -Be $Expected.ServiceBusNamespace.Sku.Name
    #     $sbNamespace.Sku.Tier.ToString() | Should -Be $Expected.ServiceBusNamespace.Sku.Tier
    # }
    It "Les tags nécessaires sont présents et ont les bonnes valeurs" {
      foreach ($tagExpected in $Expected.ServiceBusNamespace.Tags.Keys){
          #le tag est présent
          $tagExpected | Should -BeIn $sbNamespace.Tags.Keys 
          #la valeur est ok
          $sbNamespace.Tags.Item($tagExpected) | Should -Be $Expected.ServiceBusNamespace.Tags.Item($tagExpected)
      }
    }
    It "Le ServiceBus contient le bon nombre de queues" {
        $sbQueues.Count | Should -Be $Expected.ServiceBusQueues.Count
    }
}



###############  Tests de conformité des queues du service bus ###############
Describe 'Validation de la conformité des queues du service bus' {
    foreach ($sbQueue in $sbQueues){
        $ExpectedObject = $Expected.ServiceBusQueues | Where-Object {$_.QueueName -eq $sbQueue.Name}
        It "Le nom de la Queue est correct" {
            $sbQueue.Name | Should -Be $ExpectedObject.QueueName
        }
        # It "L'état (Status) de la Queue est correct" {
        #     $sbQueue.Status.ToString() | Should -Be $ExpectedObject.Status
        # }
        It "Le LockDuration de la Queue est correct" {
            $sbQueue.LockDuration | Should -Be $ExpectedObject.LockDuration
        }
        It "Le DefaultMessageTimeToLive de la Queue est correct" {
            $sbQueue.DefaultMessageTimeToLive | Should -Be $ExpectedObject.DefaultMessageTimeToLive
        }
        It "Le MaxDeliveryCount de la Queue est correct" {
            $sbQueue.MaxDeliveryCount | Should -Be $ExpectedObject.MaxDeliveryCount
        }
        It "Le MaxSizeInMegabytes de la Queue est correct" {
            $sbQueue.MaxSizeInMegabytes | Should -Be $ExpectedObject.MaxSizeInMegabytes
        }
        It "Le RequiresDuplicateDetection de la Queue est correct" {
            $sbQueue.RequiresDuplicateDetection | Should -Be $ExpectedObject.RequiresDuplicateDetection
        }
    }
}
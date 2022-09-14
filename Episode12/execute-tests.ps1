
# Install-Module -Name Pester -Force -SkipPublisherCheck
# import-module Pester -Passthru
# Connect-AzAccount
# Set-AzContext -Subscription 'Microsoft Azure Sponsorship'


Clear-Host

$container = New-PesterContainer `
-Path '.\Tests\runatcloud.tests.ps1' `
-Data @{ `
	ResourceGroupName = 'runatcloud-rg'; ServiceBusName = 'runatcloud-pester'; `
	DataFilePath = '.\Tests\Data\runatcloud.prod.data.psd1'; `
	SkipConnection = 'Y'; `
}

$config = New-PesterConfiguration
$config.Run.Container = $container

Invoke-Pester -Configuration $config
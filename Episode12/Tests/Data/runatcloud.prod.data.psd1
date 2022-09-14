@{
    
    ResourceGroup = @{
		Name = 'runatcloud-rg'
		Location = 'canada central'
	}


    ServiceBusNamespace = @{
        Name = 'runatcloud-pester'
        Location = 'canada central'
        ResourceGroupName = 'runatcloud-rg'
        Sku = @{
            Name = 'Basic'
            Tier = 'Basic'
        }
        Tags = @{
            Projet = 'runatcloud'
            Environnement = 'prod'
        }
    }


    ServiceBusQueues = @(
        @{
            QueueName = 'prioritaires'
            LockDuration = 'PT30S'
            DefaultMessageTimeToLive = 'P14D'
            MaxDeliveryCount = 10
            MaxSizeInMegabytes = 1024
            Status = 'Active'
            RequiresDuplicateDetection = $false            
        }
        @{
            QueueName = 'standards'
            LockDuration = 'PT30S'
            DefaultMessageTimeToLive = 'P7D'
            MaxDeliveryCount = 10
            MaxSizeInMegabytes = 1024
            Status = 'Active'
            RequiresDuplicateDetection = $false            
        }
        @{
            QueueName = 'low'
            LockDuration = 'PT30S'
            DefaultMessageTimeToLive = 'P2D'
            MaxDeliveryCount = 2
            MaxSizeInMegabytes = 1024
            Status = 'Active'
            RequiresDuplicateDetection = $false            
        }
    )
}
param virtualMachineScaleSets_vmss1_name string = 'vmss1'
param networkSecurityGroups_vmss1_nsg_externalid string = '/subscriptions/dbed4dcb-b39a-4513-8a47-c86bd6b5fd8a/resourceGroups/AZ-104-M8-54B69Q8AUS/providers/Microsoft.Network/networkSecurityGroups/vmss1-nsg'
param virtualNetworks_vmss_vnet_externalid string = '/subscriptions/dbed4dcb-b39a-4513-8a47-c86bd6b5fd8a/resourceGroups/AZ-104-M8-54B69Q8AUS/providers/Microsoft.Network/virtualNetworks/vmss-vnet'
param loadBalancers_vmss_lb_externalid string = '/subscriptions/dbed4dcb-b39a-4513-8a47-c86bd6b5fd8a/resourceGroups/AZ-104-M8-54B69Q8AUS/providers/Microsoft.Network/loadBalancers/vmss-lb'
param disks_vmss1_vmss1_1_disk1_babdd8976d3a483f850853af2102a376_externalid string = '/subscriptions/dbed4dcb-b39a-4513-8a47-c86bd6b5fd8a/resourceGroups/AZ-104-M8-54B69Q8AUS/providers/Microsoft.Compute/disks/vmss1_vmss1_1_disk1_babdd8976d3a483f850853af2102a376'

resource virtualMachineScaleSets_vmss1_name_resource 'Microsoft.Compute/virtualMachineScaleSets@2024-11-01' = {
  name: virtualMachineScaleSets_vmss1_name
  location: 'eastus'
  sku: {
    name: 'Standard_D2alds_v6'
    tier: 'Standard'
    capacity: 1
  }
  zones: [
    '1'
    '2'
    '3'
  ]
  properties: {
    singlePlacementGroup: false
    orchestrationMode: 'Uniform'
    upgradePolicy: {
      mode: 'Manual'
    }
    scaleInPolicy: {
      rules: [
        'Default'
      ]
      forceDeletion: false
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: '${virtualMachineScaleSets_vmss1_name}vkaj'
        adminUsername: 'localadmin'
        windowsConfiguration: {
          provisionVMAgent: true
          enableAutomaticUpdates: true
        }
        secrets: []
        allowExtensionOperations: true
        requireGuestProvisionSignal: true
      }
      storageProfile: {
        osDisk: {
          osType: 'Windows'
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
          diskSizeGB: 127
        }
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2019-datacenter-gensecond'
          version: 'latest'
        }
        diskControllerType: 'NVMe'
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'vmss-vnet-nic01'
            properties: {
              primary: true
              enableAcceleratedNetworking: true
              disableTcpStateTracking: false
              networkSecurityGroup: {
                id: networkSecurityGroups_vmss1_nsg_externalid
              }
              dnsSettings: {
                dnsServers: []
              }
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: 'vmss-vnet-nic01-defaultIpConfiguration'
                  properties: {
                    primary: true
                    subnet: {
                      id: '${virtualNetworks_vmss_vnet_externalid}/subnets/subnet0'
                    }
                    privateIPAddressVersion: 'IPv4'
                    loadBalancerBackendAddressPools: [
                      {
                        id: '${loadBalancers_vmss_lb_externalid}/backendAddressPools/bepool'
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: []
      }
    }
    overprovision: false
    doNotRunExtensionsOnOverprovisionedVMs: false
    zoneBalance: false
    platformFaultDomainCount: 1
  }
}

resource virtualMachineScaleSets_vmss1_name_1 'Microsoft.Compute/virtualMachineScaleSets/virtualMachines@2024-11-01' = {
  parent: virtualMachineScaleSets_vmss1_name_resource
  name: '1'
  location: 'eastus'
  sku: {
    name: 'Standard_D2alds_v6'
    tier: 'Standard'
  }
  zones: [
    '2'
  ]
  properties: {
    networkProfileConfiguration: {
      networkInterfaceConfigurations: [
        {
          name: 'vmss-vnet-nic01'
          properties: {
            primary: true
            enableAcceleratedNetworking: true
            disableTcpStateTracking: false
            networkSecurityGroup: {
              id: networkSecurityGroups_vmss1_nsg_externalid
            }
            dnsSettings: {
              dnsServers: []
            }
            enableIPForwarding: false
            ipConfigurations: [
              {
                name: 'vmss-vnet-nic01-defaultIpConfiguration'
                properties: {
                  primary: true
                  subnet: {
                    id: '${virtualNetworks_vmss_vnet_externalid}/subnets/subnet0'
                  }
                  privateIPAddressVersion: 'IPv4'
                  loadBalancerBackendAddressPools: [
                    {
                      id: '${loadBalancers_vmss_lb_externalid}/backendAddressPools/bepool'
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
    hardwareProfile: {
      vmSize: 'Standard_D2alds_v6'
    }
    resilientVMDeletionStatus: 'Disabled'
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: 'vmss1_vmss1_1_disk1_babdd8976d3a483f850853af2102a376'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: disks_vmss1_vmss1_1_disk1_babdd8976d3a483f850853af2102a376_externalid
        }
        diskSizeGB: 127
      }
      dataDisks: []
      diskControllerType: 'NVMe'
    }
    osProfile: {
      computerName: 'vmss1vkaj000001'
      adminUsername: 'localadmin'
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: '${virtualMachineScaleSets_vmss1_name_1.id}/networkInterfaces/vmss-vnet-nic01'
        }
      ]
    }
  }
}

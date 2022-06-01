variable "location" {
    type = string
    default = "northeurope"
    description = "location where you want to create RG"
}
###### Subnet #######
variable "subnet" {
    type = map(any)
    default = {
        subnet_1 = {
            name = "nodesubnet"
            address_prefixes = ["10.10.10.0/25"]
      }
        subnet_2 = {
            name = "postgres"
            address_prefixes = ["10.10.10.128/26"]
      }
        bastion_subnet = {
            name = "AzureBastionSubnet"
            address_prefixes = ["10.10.10.192/26"]
      }            
    }  
}
###### End Subnet #######
variable "postgres_size" {
    type = string
    default = "Standard_D2as_v4"
}
#RG calling

module "resource_group" {
  source = "../../modules/resource_group"
  name = "akshay_rg"
  location = "westus"
}


#STORAGE ACCOUNT Calling

module "storage_account" {
    depends_on = [ module.resource_group ]
    source = "../../modules/storage_account"
    name = "askstorage123"
    resource_group_name = module.resource_group.name
    location = module.resource_group.location
    account_tier = "Standard"
    account_replication_type = "LRS"
  
}


# VNET calling

module "virtual_network" {
    depends_on = [ module.resource_group ]
    source = "../../modules/vnet"
    name = "akshay_vnet"
    address_space = ["10.0.0.0/16"]
    resource_group_name = module.resource_group.name
    location = module.resource_group.location
}


# SUBNET calling

module "subnetwork" {
  depends_on = [ module.virtual_network ]
  source = "../../modules/subnet"
  name = "subnet1"
  resource_group_name = module.resource_group.name
  virtual_network_name = module.virtual_network.name
  address_prefixes = ["10.0.1.0/24"]

  }


# PIP calling

module "public_ip" {
    depends_on = [ module.resource_group ]
    source = "../../modules/pip"
    name = "akshay_pip"
    resource_group_name = module.resource_group.name
    location = module.resource_group.location
    allocation_method = "Static"

}

# Resource Group

module "rg" {
  source = "./modules/rg"
  rg_name = var.rg_name
  rg_location = var.location
  rg_tags = var.tags
}

# Networking

module "vnet" {
  source = "./modules/vnet"
  count = 2
  vnet_name = "${var.vnet_name}-${count.index}"
  location = module.rg.rg_location
  rg_name = module.rg.rg_name
  vnet_address_space = ["10.${count.index}.0.0/16"]
  tags = var.tags
}

module "subnet" {
  source = "./modules/subnet"
  count = 1
  subnet_name = "${module.vnet[0].vnet_name}-${var.subnet_name}-${count.index}"
  vnet_name = module.vnet[0].vnet_name
  rg_name = module.rg.rg_name
  subnet_address_prefixes = ["10.0.${count.index}.0/24"]
}

module "subnet1" {
  source = "./modules/subnet"
  count = 1
  subnet_name = "${module.vnet[1].vnet_name}-${var.subnet_name}-${count.index}"
  vnet_name = module.vnet[1].vnet_name
  rg_name = module.rg.rg_name
  subnet_address_prefixes = ["10.1.${count.index}.0/24"]
}

module "peering" {
  source = "./modules/vnet_2way_peering"
  rg_name = module.rg.rg_name
  vnet1_id = module.vnet[0].vnet_id
  vnet1_name = module.vnet[0].vnet_name
  vnet2_id = module.vnet[1].vnet_id
  vnet2_name = module.vnet[1].vnet_name
}
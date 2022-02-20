# General

location = "uksouth"

tags = {
    Environment = "Test"
    Owner = "Chris"
}

# Resource Group

rg_name = "cb-pipelinedemo"

# Virtual Network

vnet_name = "cb-vnet"

vnet_address_space = ["10.0.0.0/16"]

# Subnet

subnet_name = "cb-subnet"

subnet_address_prefixes = ["10.0.1.0/24"]

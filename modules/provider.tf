terraform {


  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.74.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}

}

provider "kubernetes" {
  config_path = "~/.kube/config"
}


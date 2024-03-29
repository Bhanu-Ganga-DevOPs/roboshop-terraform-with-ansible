module "vpc" {
  source = "git::https://github.com/Bhanu-Ganga-DevOPs/tf-module-vpc.git"
  for_each = var.vpc
  cidr_block = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env
}
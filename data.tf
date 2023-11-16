module "pdata" {
  source = "git::https://github.com/KPMG-UK/ie-cdd-san-data.git/?ref=main"

  environment = var.environment
  include_aws = false
}


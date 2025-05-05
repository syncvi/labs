environment_name = "lmao"
instance_count   = 7
enabled          = true
regions          = ["westus", "eastus"]
region_instance_count = {
  "westus" = 3
  "eastus" = 4
}
region_set = ["westus", "eastus"]
sku_settings = {
  kind = "lol"
  tier = "lolz"
}

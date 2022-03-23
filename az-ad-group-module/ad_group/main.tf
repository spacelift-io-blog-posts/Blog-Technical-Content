resource "azuread_group" "ad_group" {
  count            = 3
  display_name     = var.ad_group_names[count.index]
  security_enabled = true
  mail_enabled     = false
}
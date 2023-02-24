variable "vault_addr" {
  default="https://vault.kyndryl.net/"
  #default="http://127.0.0.1:8200"
}
variable "vault_token" {
  default = "hvs.CAESIJ4Uuq23Vq-1r9k7uYOv352bpMeB8ovw1-S8EL_MYuyfGikKImh2cy5LRnhhUEM0UjFxaUl6bWlDbUlyaGR2cVcuQVl6ZmQQnPG2VQ"
 # default = "root01~"
}

variable "vault_namespace" {
  default = "kyndryl/KYNDRYL_PRACTICES/"
}

#enter placeholder
variable "vault_mount_placeholder"{
  default = "kv-cricket"
}
#enter policy name
variable "policy_name" {
 default = "kv-cricket-policy"
}

variable "group_name"{
  default = "group-cricket"
}
variable "vault_entity"{
  default = "Siripi.Venkatarameswara.Reddy@kyndryl.com"
}

#key values
variable "appid"{
  default = "1230987654"
}

variable "secretid"{
  default = "12345678"
}
variable "tenantid"{
  default = "87654"
}
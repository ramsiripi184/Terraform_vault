variable "vault_addr" {
  #default="https://vault.kyndryl.net/"
  default="http://127.0.0.1:8200"
}
variable "vault_token" {
 # default = "hvs-1r9k7uYOv352bpMeB8ovw1-S8EL_MYuyfGikKImh2cy5LRnhhUEM0UjFxaUl6bWlDbUlyaGR2cVcuQVl6ZmQQnPG2VQ"
  default = "root"
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

variable "second_entity"{
  default = "venkat"
}

#key values
variable "vmbuildid"{
  default = "876435645675678854"
}

variable "clientid"{
  default = "8764356464354"
}
variable "tenantid"{
  default = "8763245678654354"
}
variable "secretid"{
  default = "8754543534654"
}
variable "subscriptionid"{
  default = "87324567865435674567654"
}
variable "pullsecretid"{
  default = "87565654332654"
}
variable "tokenid"{
  default = "8765678765454"
}
variable "objectid"{
  default = "87634554"
}
variable "aadid"{
  default = "876543245654"
}
variable "aadsecretid"{
  default = "8765432456541"
}

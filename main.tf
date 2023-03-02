provider "vault" {
	address = "${var.vault_addr}"
	token = "${var.vault_token}"
	namespace = "${var.vault_namespace}"
}
 # To Create a place holder/ secret engine

resource "vault_mount" "placeholder" {
  path        = "${var.vault_mount_placeholder}"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

# To create a vault policy

resource "vault_policy" "vault-policy" {
  name = "${var.policy_name}"
  policy = <<EOT
  path "kv-cricket/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

# to create a identity group 
resource "vault_identity_group" "vault_group" {
  name     = "${var.group_name}"
  type     = "internal"
  policies = ["${var.policy_name}"]
  external_member_entity_ids  = true


  metadata = {
    version = "2"
  }

  depends_on = [
    vault_mount.placeholder,
    vault_policy.vault-policy
 ]
}

# creating an entity

resource "vault_identity_entity" "entity" {
  name      = "Siripi.Venkatarameswara.Reddy@kyndryl.com"
  policies  = ["${var.policy_name}"]
  metadata  = {
    foo = "bar"
  }
  
}

# reading the entity/user name...
data "vault_identity_entity" "vault_entity" {
  entity_name = "${var.vault_entity}"
  depends_on = [vault_identity_entity.entity]
}



# mapping the group id and the user id

resource "vault_identity_group_member_entity_ids" "vault_mapping" {

  exclusive         = false
  member_entity_ids = [data.vault_identity_entity.vault_entity.id]
  
   group_id          = vault_identity_group.vault_group.id

   depends_on = [
    vault_mount.placeholder,
    vault_policy.vault-policy,
    vault_identity_group.vault_group,
    vault_identity_entity.entity
     ]
}


# creating the secrts and adding the key values

resource "vault_kv_secret_v2" "vault_secret" {
  mount                      = vault_mount.placeholder.path
  name                       = "secret"
  #path = "${vault_mount.placeholder.path}/secret"
  data_json = jsonencode(
  {
    TF_CLOUD_ARO_KPS_DEV_VMBUILD = "${var.vmbuildid}",
    ARM_CLIENT_ID = "${var.clientid}",
    ARM_TENANT_ID = "${var.tenantid}",
    ARM_CLIENT_SECRET = "${var.secretid}",
    ARM_SUBSCRIPTION_ID = "${var.subscriptionid}",
    ARM_PULL_SECRET = "${var.pullsecretid}",
    TF_CLOUD_API_TOKEN = "${var.tokenid}",
    CIO_KPS_RP_AAD_SP_OBJECT_ID = "${var.objectid}",
    CIO_KPS_NEW_AAD_ID = "${var.aadid}",
    CIO_KPS_NEW_AAD_SECRET = "${var.aadsecretid}"
  }
  )
   depends_on = [
    vault_mount.placeholder,
    vault_policy.vault-policy,
    vault_identity_group.vault_group,
    vault_identity_group_member_entity_ids.vault_mapping
 ]

}

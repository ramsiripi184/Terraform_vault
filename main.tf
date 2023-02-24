provider "vault" {
	address = "${var.vault_addr}"
	token = "${var.vault_token}"
	namespace = "${var.vault_namespace}"
}

resource "vault_mount" "placeholder" {
  path        = "${var.vault_mount_placeholder}"
  type        = "kv"
  options     = { version = "1" }
  description = "KV Version 1 secret engine mount"
}

resource "vault_policy" "vault-policy" {
  name = "${var.policy_name}"
  policy = <<EOT
  path "kv-cricket/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}

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

data "vault_identity_entity" "vault_entity" {
  entity_name = "${var.vault_entity}"
}

resource "vault_identity_group_member_entity_ids" "vault_mapping" {

  exclusive         = true
  member_entity_ids = [data.vault_identity_entity.vault_entity.id]
   group_id          = vault_identity_group.vault_group.id

   depends_on = [
    vault_mount.placeholder,
    vault_policy.vault-policy,
    vault_identity_group.vault_group
     ]
}


resource "vault_kv_secret" "vault_secret" {
  path = "${vault_mount.placeholder.path}/secret"
  data_json = jsonencode(
  {
    appid = "${var.appid}",
    secretid = "${var.secretid}",
    tenantid = "${var.tenantid}"
  }
  )
   depends_on = [
    vault_mount.placeholder,
    vault_policy.vault-policy,
    vault_identity_group.vault_group,
    vault_identity_group_member_entity_ids.vault_mapping
 ]

}
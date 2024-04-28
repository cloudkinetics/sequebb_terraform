module "wrapper" {
  source = "../"

  for_each = var.items

  access_logs                                                  = try(each.value.access_logs, var.defaults.access_logs, {})
  additional_target_group_attachments                          = try(each.value.additional_target_group_attachments, var.defaults.additional_target_group_attachments, {})
  associate_web_acl                                            = try(each.value.associate_web_acl, var.defaults.associate_web_acl, false)
  connection_logs                                              = try(each.value.connection_logs, var.defaults.connection_logs, {})
  create                                                       = try(each.value.create, var.defaults.create, true)
  create_security_group                                        = try(each.value.create_security_group, var.defaults.create_security_group, true)
  customer_owned_ipv4_pool                                     = try(each.value.customer_owned_ipv4_pool, var.defaults.customer_owned_ipv4_pool, null)
  default_port                                                 = try(each.value.default_port, var.defaults.default_port, 80)
  default_protocol                                             = try(each.value.default_protocol, var.defaults.default_protocol, "HTTP")
  desync_mitigation_mode                                       = try(each.value.desync_mitigation_mode, var.defaults.desync_mitigation_mode, null)
  dns_record_client_routing_policy                             = try(each.value.dns_record_client_routing_policy, var.defaults.dns_record_client_routing_policy, null)
  drop_invalid_header_fields                                   = try(each.value.drop_invalid_header_fields, var.defaults.drop_invalid_header_fields, true)
  enable_cross_zone_load_balancing                             = try(each.value.enable_cross_zone_load_balancing, var.defaults.enable_cross_zone_load_balancing, true)
  enable_deletion_protection                                   = try(each.value.enable_deletion_protection, var.defaults.enable_deletion_protection, true)
  enable_http2                                                 = try(each.value.enable_http2, var.defaults.enable_http2, null)
  enable_tls_version_and_cipher_suite_headers                  = try(each.value.enable_tls_version_and_cipher_suite_headers, var.defaults.enable_tls_version_and_cipher_suite_headers, null)
  enable_waf_fail_open                                         = try(each.value.enable_waf_fail_open, var.defaults.enable_waf_fail_open, null)
  enable_xff_client_port                                       = try(each.value.enable_xff_client_port, var.defaults.enable_xff_client_port, null)
  enforce_security_group_inbound_rules_on_private_link_traffic = try(each.value.enforce_security_group_inbound_rules_on_private_link_traffic, var.defaults.enforce_security_group_inbound_rules_on_private_link_traffic, null)
  idle_timeout                                                 = try(each.value.idle_timeout, var.defaults.idle_timeout, null)
  internal                                                     = try(each.value.internal, var.defaults.internal, null)
  ip_address_type                                              = try(each.value.ip_address_type, var.defaults.ip_address_type, null)
  listeners                                                    = try(each.value.listeners, var.defaults.listeners, {})
  load_balancer_type                                           = try(each.value.load_balancer_type, var.defaults.load_balancer_type, "application")
  name                                                         = try(each.value.name, var.defaults.name, null)
  name_prefix                                                  = try(each.value.name_prefix, var.defaults.name_prefix, null)
  preserve_host_header                                         = try(each.value.preserve_host_header, var.defaults.preserve_host_header, null)
  putin_khuylo                                                 = try(each.value.putin_khuylo, var.defaults.putin_khuylo, true)
  route53_records                                              = try(each.value.route53_records, var.defaults.route53_records, {})
  security_group_description                                   = try(each.value.security_group_description, var.defaults.security_group_description, null)
  security_group_egress_rules                                  = try(each.value.security_group_egress_rules, var.defaults.security_group_egress_rules, {})
  security_group_ingress_rules                                 = try(each.value.security_group_ingress_rules, var.defaults.security_group_ingress_rules, {})
  security_group_name                                          = try(each.value.security_group_name, var.defaults.security_group_name, null)
  security_group_tags                                          = try(each.value.security_group_tags, var.defaults.security_group_tags, {})
  security_group_use_name_prefix                               = try(each.value.security_group_use_name_prefix, var.defaults.security_group_use_name_prefix, true)
  security_groups                                              = try(each.value.security_groups, var.defaults.security_groups, [])
  subnet_mapping                                               = try(each.value.subnet_mapping, var.defaults.subnet_mapping, [])
  subnets                                                      = try(each.value.subnets, var.defaults.subnets, null)
  tags                                                         = try(each.value.tags, var.defaults.tags, {})
  target_groups                                                = try(each.value.target_groups, var.defaults.target_groups, {})
  timeouts                                                     = try(each.value.timeouts, var.defaults.timeouts, {})
  vpc_id                                                       = try(each.value.vpc_id, var.defaults.vpc_id, null)
  web_acl_arn                                                  = try(each.value.web_acl_arn, var.defaults.web_acl_arn, null)
  xff_header_processing_mode                                   = try(each.value.xff_header_processing_mode, var.defaults.xff_header_processing_mode, null)
}
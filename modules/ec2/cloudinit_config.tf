data "cloudinit_config" "ft_wp_init_config" {
  for_each      = { for env in var.env_list : env => env }
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      write_files = [
       
        {
          path        = "/app/docker-compose.yml",
          permissions = "0644"
          owner       = "root:root"
          content     = file("wordpress/docker-compose.yml"),
        },
        {
          path        = "/app/.env",
          permissions = "0644"
          owner       = "root:root"
          content = templatefile("env_template", {
            RDS_ENDPOINT = var.db_endpoint[each.key]
            RDS_USERNAME = var.db_user
            RDS_PASSWORD = var.db_password
            RDS_DB_NAME  = var.db_name[each.key]
            WP_URL       = "${var.wordpress_subdomain}-${each.key}.${var.domain_name}"
            WP_TITLE     = "${var.wordpress_subdomain}-${each.key}-title"
          }),
        },
      ],
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = templatefile("utils/setup.sh", {
      EFS_DNS_NAME = var.efs_dns_name
      VOLUME_NAME = "${each.key}-data"
    })
  }
}

locals {
  initfile = templatefile(./cloudinitdata/webservers.sh.tpl)
}

data "template_cloud_init_config" "webserverinit" {
    gzip = false
    base64_encode=true

    part {
    filename="webservers.sh.tpl"
    content_type = "text/x-shellscript"
    content      = "local.initfile.rendered"
  }
  
}
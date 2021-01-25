/* locals {
  initfile = file("./cloud-init/webservers.sh")
} */


#Load script file
data "template_file" "script" {
  template = file("./cloud-init/webservers.sh")
}


#Script cloud init
data "cloudinit_config" "webserverinit" {
    gzip = false
    base64_encode=true

    part {
    content_type = "text/x-shellscript"
    content      = data.template_file.script.rendered
  }
  
}
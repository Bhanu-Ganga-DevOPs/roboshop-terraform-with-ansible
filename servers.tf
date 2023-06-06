#
#
#resource "aws_instance" "instance" {
#
#  ################## resource creation using Count #################
##  count = length(var.components)
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = var.components[count.index]
##  }
#  ################## END of resource creation using Count #################
#
#  for_each               = var.components
#  ami                    = data.aws_ami.centos.image_id
#  instance_type          = each.value["instance_type"]
#  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
#
#  tags = {
#    Name = each.value["name"]
#  }
#}
#
#
#resource "null_resource" "provisioner" {
#
#  depends_on = [aws_instance.instance, aws_route53_record.dns-record]
#  for_each   = var.components
#  provisioner "remote-exec" {
#
#    connection {
#      type     = "ssh"
#      user     = "centos"
#      password = "DevOps321"
#      host     = aws_instance.instance[each.value["name"]].private_ip
#    }
#
#    inline = [
#      "echo -------- ${each.value["name"]} ---------",
#      "rm -rf roboshop-shell",
#      "git clone https://github.com/Bhanu-Ganga-DevOPs/roboshop-shell",
#      "cd roboshop-shell",
#      "sudo bash ${each.value["name"]}.sh  ${lookup(each.value,"password","null")} "
#    ]
#  }
#}
#
#
#resource "aws_route53_record" "dns-record" {
#  for_each               = var.components
#  zone_id                = "Z02296781GEG0AJVP8QEV"
#  name                   = "${each.value["name"]}-dev.gangabhavanikatraparthi.online"
#  type                   = "A"
#  ttl                    = 30
#  records                = [aws_instance.instance[each.value["name"]].private_ip]
#}
#
#
#
################### Manual creation of resource and Route53 records creation using Count #################
#
##resource "aws_instance" "user" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "user"
##  }
##}
##
##resource "aws_instance" "catalogue" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "catalogue"
##  }
##}
##
##resource "aws_instance" "cart" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "cart"
##  }
##}
##
##resource "aws_instance" "shipping" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "shipping"
##  }
##}
##
##resource "aws_instance" "payment" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "payment"
##  }
##}
##
##resource "aws_instance" "mongodb" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "mongodb"
##  }
##}
##
##resource "aws_instance" "mysql" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "mysql"
##  }
##}
##
##resource "aws_instance" "redis" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "redis"
##  }
##}
##
##resource "aws_instance" "rabbitmq" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "rabbitmq"
##  }
##}
##
##resource "aws_instance" "dispatch" {
##  ami           = data.aws_ami.centos.image_id
##  instance_type = var.instance_type
##  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
##
##  tags = {
##    Name = "dispatch"
##  }
##}
#
#
##
##resource "aws_route53_record" "user" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "user-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.user.private_ip]
##}
##
##resource "aws_route53_record" "catalogue" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "catalogue-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.catalogue.private_ip]
##}
##
##resource "aws_route53_record" "cart" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "cart-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.cart.private_ip]
##}
##
##resource "aws_route53_record" "shipping" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "shipping-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.shipping.private_ip]
##}
##
##resource "aws_route53_record" "payment" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "payment-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.payment.private_ip]
##}
##
##resource "aws_route53_record" "mongodb" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "mongodb-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.mongodb.private_ip]
##}
##
##resource "aws_route53_record" "mysql" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "mysql-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.mysql.private_ip]
##}
##
##resource "aws_route53_record" "redis" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "redis-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.redis.private_ip]
##}
##
##resource "aws_route53_record" "rabbitmq" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "rabbitmq-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.rabbitmq.private_ip]
##}
##
##resource "aws_route53_record" "dispatch" {
##  zone_id = "Z02296781GEG0AJVP8QEV"
##  name    = "dispatch-dev.gangabhavanikatraparthi.online"
##  type    = "A"
##  ttl     = 30
##  records = [aws_instance.dispatch.private_ip]
##}
#
#
################### End of Manual creation of resource and Route53 records creation using Count #################
#
#




module "servers" {
  for_each = var.components
  source = "./module"

  component_name   = each.value["name"]
  instance_type    = each.value["instance_type"]
  env              = var.env
  password         = lookup(each.value,"password","null" )

}

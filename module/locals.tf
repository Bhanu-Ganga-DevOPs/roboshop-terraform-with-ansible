locals {
  name = var.component_name != "" ? "${var.component_name} - ${var.env}" : var.component_name
  db_commands = [
      "rm -rf roboshop-shell",
      "git clone https://github.com/Bhanu-Ganga-DevOPs/roboshop-shell",
      "cd roboshop-shell",
      "sudo bash ${var.component_name}.sh ${var.password}"
  ]
  app_commands = [
    "sudo labauto ansible",
    "ansible-pull -i localhost, -U https://github.com/Bhanu-Ganga-DevOPs/roboshop-ansible.git  -e role_name=${var.component_name} -e env=${var.env} roboshop.yml"
  ]

  db_tags = {
    Name = "${var.component_name}.sh ${var.env}"
  }

  app_tags = {
    Name = "${var.component_name}.sh ${var.env}"
    Monitor = "true"
  }
}
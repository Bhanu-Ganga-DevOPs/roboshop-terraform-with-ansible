resource "aws_instance" "instance" {
  ami                    = data.aws_ami.centos.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [data.aws_security_group.allow-all-security-group.id]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name

  tags = {
    Name = local.name
  }
}

resource "null_resource" "provisioner" {

  triggers = {
    private_ip = aws_instance.instance.private_ip
  }
#  count        = var.provisioner ? 1 :0
  depends_on   = [aws_instance.instance, aws_route53_record.records]
  provisioner "remote-exec" {

    connection {
      type     = "ssh"
      user     = "centos"
      password = "DevOps321"
      host     = aws_instance.instance.private_ip
    }

    inline = var.application_type == "database" ? local.db_commands : local.app_commands
  }
}


resource "aws_route53_record" "records" {
  zone_id = "Z02296781GEG0AJVP8QEV"
  name    = "${var.component_name}-dev.gangabhavanikatraparthi.online"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}


resource "aws_iam_role" "role" {
  name = "${var.component_name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.component_name}-${var.env}-role"
  }
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.component_name}-${var.env}-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_role_policy" "ssm_ps_policy" {
  name = "${var.component_name}-${var.env}-ssm_ps_policy"
  role = aws_iam_role.role.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:GetParametersForImport",
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource": [
          "arn:aws:ssm:us-east-1:555138969324:parameter/${var.env}.${var.component_name}.*",
          "arn:aws:kms:us-east-1:555138969324:key/778981c1-c82b-4f3a-aa0e-91dedf2cc6da"
        ]
      }
    ]
  })
}



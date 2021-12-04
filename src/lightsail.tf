resource "aws_lightsail_instance" "trackmarket" {
  name              = "trackmarket"
  availability_zone = var.region_az
  blueprint_id      = "nodejs"
  bundle_id         = "nano_2_0"
  key_pair_name     = "KeyJin"
  tags = {
    Name = "trackmarket"
  }
}
resource "aws_lightsail_static_ip" "trackmarket_eip" {
  name = "static_ip_terraform_managed"
}

resource "aws_lightsail_static_ip_attachment" "trackmarket_attach_eip" {
  static_ip_name = aws_lightsail_static_ip.trackmarket_eip.id
  instance_name  = aws_lightsail_instance.trackmarket.id
}

resource "aws_lightsail_instance_public_ports" "trackmarket_port" {
  instance_name = aws_lightsail_instance.trackmarket.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    cidrs = ["106.72.163.65/32"]
  }

  port_info {
    protocol  = "tcp"
    from_port = 80
    to_port   = 80
  }

  port_info {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
  }

  port_info {
    protocol  = "tcp"
    from_port = 465
    to_port   = 465
  }

  port_info {
    protocol  = "tcp"
    from_port = 3000
    to_port   = 3000
  }
}

resource "aws_lightsail_instance" "trackmarket_db" {
  name              = "trackmarket-db"
  availability_zone = var.region_az
  blueprint_id      = "amazon_linux_2"
  bundle_id         = "nano_2_0"
  key_pair_name     = "KeyJin"
  tags = {
    Name = "trackmarket"
  }
  user_data = <<EOF
    echo -e "[mongodb-org-4.0]¥nname=MongoDB Repository¥nbaseurl=https://repo.mongodb.org/yum/amazon/2013.03/mongodb-org/4.0/x86_64/¥ngpgcheck=1¥nenabled=1¥ngpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc" >> /etc/yum.repos.d/mongodb-org-4.0.repo
    yum install -y mongodb-org
    service mongod start
	EOF
}

resource "aws_lightsail_static_ip" "trackmarket_db_eip" {
  name = "static_ip_terraform_managed2"
}

resource "aws_lightsail_static_ip_attachment" "trackmarket_db_attach_eip" {
  static_ip_name = aws_lightsail_static_ip.trackmarket_db_eip.id
  instance_name  = aws_lightsail_instance.trackmarket_db.id
}

resource "aws_lightsail_instance_public_ports" "trackmarket_db_port" {
  instance_name = aws_lightsail_instance.trackmarket_db.name

  port_info {
    protocol  = "tcp"
    from_port = 22
    to_port   = 22
    //cidrs = ["106.72.163.65/32"]
  }

  port_info {
    protocol  = "tcp"
    from_port = 27017
    to_port   = 27017
    cidrs = [ 
      "13.115.129.67/32",
      "35.75.211.19/32",
      "106.72.163.65/32",
      "127.0.0.1/32" 
    ]
  }
}

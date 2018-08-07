provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

# SUPPLY AWS KEY PAIR FOR LOGGING IN
#resource "aws_key_pair" "winlogin" {
#  key_name	= ""
#  public_key	= ""
#}

# CREATE SECURITY GROUP FOR EC2 INSTANCE
# CREATE NETWORK ACL RULES TO ALLOW INBOUND RDP AND WINRM CONNECTIONS
resource "aws_security_group" "windows_sg" {
  name = "${var.WINDOWS_SECURITY_GROUP}"

  ingress {
    from_port 	= 0
    to_port 	= 3389
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "inbound rule for RDP connections"
  }

  ingress {
    from_port 	= 0
    to_port 	= 5986
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "inbound rule for WinRM https connections"
  }

  ingress {
    from_port 	= 0
    to_port 	= 5985
    protocol 	= "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "inbound rule for WinRM connections"
  }
}




# RESOURCE CREATION

#resource "aws_instance" "ansible_controller" {
#  ami           = "ami-28e07e50"
#  instance_type = "t2.micro"
#}

resource "aws_instance" "web1" {
  ami			= "ami-6d336015"
  instance_type 	= "t2.micro"
  key_name		= "${var.AWS_KEY_PAIR}"
  security_groups	= ["${var.WINDOWS_SECURITY_GROUP}"]

  user_data = <<EOF
    <powershell>
      net user dkwami 'P@ssword12345' /add /y
      net localgroup administrators dkwami /add
    </powershell>
  EOF
}

#resource "aws_instance" "web2" {
#  ami		= "ami-6d336015"
#  instance_type = "t2.micro"
#}


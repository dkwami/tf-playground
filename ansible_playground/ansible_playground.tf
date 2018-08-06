provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}

resource "aws_instance" "ansible_controller" {
  ami           = "ami-28e07e50"
  instance_type = "t2.micro"
}

resource "aws_instance" "web1" {
  ami		= "ami-6d336015"
  instance_type = "t2.micro"
}

resource "aws_instance" "web2" {
  ami		= "ami-6d336015"
  instance_type = "t2.micro"
}


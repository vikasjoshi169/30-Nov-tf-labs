#This will create EC2 instance in Mumbai (ap-south-1) region
provider "aws" {
  region = "ap-south-1"
}

#This will create EC2 instance in Singapore (ap-southeast-1) region
provider "aws" {
  alias  = "sg"
  region = "ap-southeast-1"
}

#data block for ami
data "aws_ami" "amazon-linux-3" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

#This block will use for the creation of instance in Mumbai region 
resource "aws_instance" "mumbai-instance" {
  ami           = data.aws_ami.amazon-linux-3.id
  instance_type = "t2.micro"
  count         = 1
  tags = {
    Name = "mumbai-instance"
  }
}

#This block will use for the creation of instance in Singapore region 
resource "aws_instance" "singapore-instance" {
  ami           = "ami-059b01eb1dee1e15c"
  instance_type = "t2.micro"
  count         = 1
  provider      = aws.sg
  tags = {
    Name = "singapore-instance"
  }
}
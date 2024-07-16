provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "kek"
  region = "us-east-1"
}

resource "random_pet" "bucket_name" {
  
}

resource "random_pet" "optional_bucket_name" {
  
}

resource "aws_s3_bucket" "default" {
  bucket = "aleatoric-bucket-${random_pet.bucket_name.id}"
}

variable "number_of_aliased_buckets" {
  default = 0
}

resource "aws_s3_bucket" "aliased" {
  provider = aws.kek
  count  = var.number_of_aliased_buckets
  bucket = "aleatoric-bucket-${random_pet.optional_bucket_name.id}"
}

terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
    }
  }
}


provider "scalr" {}

resource "scalr_workspace" "cli-driven" {
  name           = "automatically_created_${random_pet.bucket_name.id}"
  environment_id = data.scalr_current_run.this.environment_id
}

data "scalr_current_run" "this" {
  
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "ubuntu" {
  count = 149
   provisioner "local-exec" {
    command = "env"
  }
  #ami                         = var.win_ami
  ami           = data.aws_ami.ubuntu.id
  #instance_type = var.instance_type1
 instance_type = sensitive("t2.nano")
  subnet_id     = var.subnet
  tags          = merge({ "Name" = format("k.kotov-test -> %s -> %s", substr("🤔🤷", 0, 1), data.aws_ami.ubuntu.name) }, var.tags)
  timeouts {
    create = "9m"
    delete = "15m"
  }
}



resource "aws_ebs_volume" "ebs-volume" {
  availability_zone = "us-east-1a"
        size = 1000000
    type = "gp2"
    }



data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowFullS3Access"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}


resource "aws_iam_role" "demo-node" {
  name = "terraform-eks-demo-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_role_policy_attachment" "demo-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.demo-node.name
}

resource "aws_iam_instance_profile" "demo-node" {
  name = "terraform-eks-demo"
  role = aws_iam_role.demo-node.name
}

resource "aws_security_group" "demo-node" {
  name        = "terraform-eks-demo-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "vpc-596aa03e"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #tags = "${
   # map(
    # "Name", "terraform-eks-demo-node",
   #"kubernetes.io/cluster/${var.cluster-name}", "owned",
   # )
  #}"
}


variable "instance_count" {
  type = string
  default = "1"
  }

variable "region" {
  type = string
  default = "us-east-1"
   }

variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "network" {
  type = string
  default = "vpc-596aa03e"
 }

variable "subnet" {
  type = string
default = "subnet-7e3fd71a"
  }

variable "associate_public_ip" {
  type    = bool
  default = true
}

variable "tags" {
  type = map
  default = {
    us-east-1 = "image-1234"
    us-west-2 = "image-4567"
  }
}

variable "cluster-name" {
  type = string
default = "new"
  }

variable "availability_zone" {
  description = "AWS availability zone to launch the VM into"
  default     = "us-east-1a"
}

#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "demo" {
  cidr_block = "10.0.0.0/16"

  tags = merge({ "Name" = format("k.kotov-test -> %s -> %s", substr ("🤔🤷", 0,1), data.aws_ami.ubuntu.name) }, var.tags)
   
}

resource "aws_subnet" "demo" {
  count = 2

  availability_zone = var.availability_zone
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.demo.id

  tags = merge({ "Name" = format("k.kotov-test -> %s -> %s", substr ("🤔🤷", 0,1), data.aws_ami.ubuntu.name) }, var.tags)
    
}

resource "aws_internet_gateway" "demo" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "terraform-eks-demo"
  }
}

resource "aws_route_table" "demo" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo.id
  }
}

resource "aws_route_table_association" "demo" {
  count = 2

  subnet_id      = aws_subnet.demo.*.id[count.index]
  route_table_id = aws_route_table.demo.id
}

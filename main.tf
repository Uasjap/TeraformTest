terraform {
  backend "s3" {
    bucket = "vasilijs-volkovs-test-tera-bucket"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}

# Define the provider and region
provider "aws" {
  region = "eu-west-1"
}

# Define the EC2 instance
resource "aws_instance" "my_instance" {
  ami           = "ami-053de3aae09d4f9a4"
  instance_type = "t3.small"  # You can adjust the instance type as needed

  key_name = null  # Proceed without a key pair

  # Network settings
  vpc_security_group_ids = ["sg-0f829c806c003c9da"]  # Select existing security group

  iam_instance_profile = "ssm_role"  # Attach IAM instance profile

  metadata_options {
    http_tokens   = "required"
    http_put_response_hop_limit = 2
    http_endpoint = "enabled"
  }

  tags = {
    Name = "Team1Test-I-hope-it-will-work"
  }
}


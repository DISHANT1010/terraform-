# key_pair 

resource "aws_key_pair" "terraform_key" {
   key_name = "terraform_key"
   public_key = file("terrakey-ec2.pub")
}

# vpc & security group

resource "aws_default_vpc" "default_vpc" {
   tags = {
    name = "Defualt vpc"
   }
}

resource "aws_security_group" "secutiy_group" {
  name = "allow_tls"
  description = "This security group created using TF"
  vpc_id = aws_default_vpc.default_vpc.id

#  inbound rule
ingress {
    to_port = 22
    from_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"
}

ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
}

ingress {
    from_port = 8000
    to_port = 8000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Django App"
}
# outbound rule
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "open for all"
}

  tags = {
    name = "allow_tls"
  }
}

# EC2 instance

resource "aws_instance" "terraform-instance" {
   for_each = tomap({
    terraform_micro_1 = "t2.micro",
    terraform_micro_2 = "t2.micro"
   })
   depends_on = [ aws_key_pair.terraform_key, aws_security_group.secutiy_group ]
   key_name = aws_key_pair.terraform_key.key_name
   security_groups = [aws_security_group.secutiy_group.name]
   instance_type = each.value
   ami = var.ec2_image_id
   user_data = file("install_nginx.sh")

   root_block_device {
     volume_size = var.env == "prd" ? 20 : var.ec2_storage_size
     volume_type = "gp3"
   }

   tags = {
    Name = each.key
   }
}

resource "aws_instance" "my_new_instacne" {
  ami = "unknown"
  instance_type = "unknown"
}
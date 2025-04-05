resource "aws_s3_bucket" "state_file_bucket" {
  bucket = "terraform-state"
  tags = {
    Name = "terraform-state"
  }
}
resource "aws_dynamodb_table" "lock_state-db" {
  name = "lock-state-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "lock-state-dynamodb"
  }
}
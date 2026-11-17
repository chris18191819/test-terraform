# AWS side — the original integration, still emulatable with floci (:4566).
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  tags = {
    Name  = "terrasuite-web"
    Owner = "platform"
  }
}

resource "aws_s3_bucket" "reports" {
  bucket = "terrasuite-reports-demo"
  tags = {
    Name  = "terrasuite-reports"
    Owner = "platform"
  }
}

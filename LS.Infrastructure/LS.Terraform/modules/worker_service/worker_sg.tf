resource "aws_security_group" "worker_sg" {
  vpc_id = var.ls_framework_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
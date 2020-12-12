resource "aws_security_group" "allow-octopusserver" {
  vpc_id      = "${aws_vpc.worker_vpc.id}"
  name        = "allow-octopusserver"
  description = "Security group that allows traffic to the worker from the Octpus Server"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10933
    to_port     = 10933
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 3389
    to_port = 3389
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-octopusserver"
  }
}

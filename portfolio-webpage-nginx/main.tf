resource "aws_security_group" "sg" {
  name = "Basic-Security-Group"
  description = "Allow port 80 for http"

  tags = {
    name = "Basic-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "eggress_rule" {
  security_group_id = aws_security_group.sg.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule" {
    security_group_id = aws_security_group.sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    ip_protocol = "tcp"
    to_port = 80
}

resource "aws_instance" "web" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t2.micro"
    vpc_security_group_ids =  [aws_security_group.sg.id]

    user_data = file("userdata.sh")

    tags = {
      name = "basic-terra"
    }
}

output "instance_public_ip" {
    value = aws_instance.web.public_ip
    description = "Website is running on this address:"
  
}
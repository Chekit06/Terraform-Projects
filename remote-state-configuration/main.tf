resource "aws_security_group" "sg" {
  name = "Basic-Security-Group"
  description = "Allow port 80 for http"

  tags = {
    name = "Basic-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "eggress-rule" {
    security_group_id = aws_security_group.sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"

}

resource "aws_vpc_security_group_ingress_rule" "ingress-rule" {
    security_group_id = aws_security_group.sg.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}

resource "aws_instance" "web" {
    ami = "ami-0ecb62995f68bb549"
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.sg.id]

    tags = {
      Name = "basic-terra-state-check" 

}  
}

output "instance_public_ip" {
    value = aws_instance.web.public_ip
    description = "The public ip of instance:"
  
}

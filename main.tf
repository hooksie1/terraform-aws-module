resource "aws_instance" "vm" {
    ami             = var.image
    instance_type   = var.size
    key_name        = var.key


    tags = {
        Name = var.name
    }
}

resource "cloudflare_record" "a_record" {
    zone_id     = var.cloudflare_zone
    name        = var.name
    value       = aws_instance.vm.public_ip
    type        = "A"
}

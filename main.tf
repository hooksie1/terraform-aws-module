resource "aws_instance" "vm" {
    ami             = var.image
    instance_type   = var.size
    key_name        = var.key


    tags = {
        Name = var.name
    }
}

data "cloudflare_zones" "default" {
    zone        = "hooks.technology"
}

resource "cloudflare_record" "a_record" {
    zone_id     = data.cloudflare_zone.default.id
    name        = var.name
    value       = aws_instance.vm.public_ip
    type        = "A"
}

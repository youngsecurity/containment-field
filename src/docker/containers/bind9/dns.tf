resource "dns_a_record_set" "tfk-01" {
    zone = "home.youngsecurity.net."
    name = "tfk-01"
    addresses = [
        "10.0.255.8"
    ]
    ttl = 30
}

resource "dns_cname_record" "whoami" {
    zone = "home.youngsecurity.net."
    name = "whoami"
    cname = "tfk-01.home.youngsecurity.net."
    ttl = 30
}

resource "dns_cname_record" "nginx" {
    zone = "home.youngsecurity.net."
    name = "nginx"
    cname = "tfk-01.home.youngsecurity.net."
    ttl = 30
}
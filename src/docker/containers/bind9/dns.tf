resource "dns_a_record_set" "tfk-01" {
    zone = "home.youngsecurity.net."
    name = "tfk-01"
    addresses = [
        "10.0.255.8"
    ]
    ttl = 30
}

resource "dns_a_record_set" "whoami" {
    zone = "home.youngsecurity.net."
    name = "whoami"
    addresses = [
        "10.0.255.144",
        "10.0.255.145"
    ]
    ttl = 30
}

resource "dns_a_record_set" "nginx" {
    zone = "home.youngsecurity.net."
    name = "nginx"
    addresses = [
        "10.0.255.146"
    ]
    ttl = 30
}
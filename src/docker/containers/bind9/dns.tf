resource "dns_a_record_set" "tfk-01" {
    zone = "home.youngsecurity.net."
    name = "tfk-01"
    addresses = [
        "10.0.255.8"
    ]
    ttl = 300
}
resource "dns_a_record_set" "tfk-01" {
    zone = "home.youngsecurity.net."
    name = "tfk-01"
    addresses = [
        "10.0.255.8"
    ]
    # Use multiple addresses for round-robin DNS
    # See https://www.terraform.io/docs/providers/dns/r/a_record_set.html
    #addresses = [
    #    "10.0.255.8",
    #    "10.0.255.9"
    #]    
    ttl = 300
}
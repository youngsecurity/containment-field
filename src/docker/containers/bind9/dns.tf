resource "dns_a_record_set" "tfk-01" {
    zone = "home.youngsecurity.net."
    name = "tfk-01"
    addresses = [
        "10.0.255.8"
    ]
    ttl = 30
}

resource "dns_a_record_set" "open-webui" {
    zone = "home.youngsecurity.net."
    name = "open-webui"
    addresses = [
        "10.0.255.148"
    ]
    ttl = 30
}
resource "dns_a_record_set" "ollama" {
    zone = "home.youngsecurity.net."
    name = "ollama"
    addresses = [
        "10.0.255.147"
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
resource "dns_cname_record" "llm" {
    zone = "home.youngsecurity.net."
    name = "llm"
    cname = "tfk-01.home.youngsecurity.net."
    ttl = 30
}
resource "dns_cname_record" "pihole" {
    zone = "home.youngsecurity.net."
    name = "pihole"
    cname = "tfk-01.home.youngsecurity.net."
    ttl = 30  
}
resource "dns_cname_record" "portainer" {
    zone = "home.youngsecurity.net."
    name = "portainer"
    cname = "tfk-01.home.youngsecurity.net."
    ttl = 30  
}
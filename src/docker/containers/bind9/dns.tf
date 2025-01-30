resource "dns_a_record_set" "macos" {
    zone = "home.youngsecurity.net."
    name = "macos"
    addresses = [
        "10.0.255.156"
    ]
}
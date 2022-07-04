#!/bin/bash

set -e

dns_verify() {
  output "Resolving DNS for $fqdn"
  ip=$(curl -6 -sL $CHECKIP_URL)
  dns_record=$(dig +short @$DNS_SERVER "$fqdn" AAAA | tail -n1)
  [ "${ip}" != "${dns_record}" ] && fail
  output "DNS verified!"
}

main() {
  fqdn="$1"
  dns_verify
  true
}

main "$1"

#!/usr/bin/env bash

main() {
	[[ -d etc ]] || mkdir etc || return 1
	[[ -d lib ]] || mkdir lib || return 2
	docker run -it --rm --name certbot \
		-v "$(pwd)/.secret:/app/.secret" \
		-v "$(pwd)/etc:/etc/letsencrypt" \
		-v "$(pwd)/lib:/var/lib/letsencrypt" \
		certbot/dns-digitalocean certonly \
		--server 'https://acme-v02.api.letsencrypt.org/directory' \
		--dns-digitalocean \
		--dns-digitalocean-credentials /app/.secret \
		--dns-digitalocean-propagation-seconds 60 \
		-d "$@"
}

main "$@"

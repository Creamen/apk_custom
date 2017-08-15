.PHONY: all

key:
	@if [ ! -s ext/openldap_exporter.yml ]; then \
		read pass ; \
		echo -n $$pass > .pass ; \
		openssl enc -salt -d -aes-256-ecb -kfile .pass < ext/openldap_exporter.yml.enc > ext/openldap_exporter.yml; \
		openssl enc -salt -d -aes-256-ecb -kfile .pass < ext/prometheus.yml.enc > ext/prometheus.yml; \
		rm -f .pass; \
		fi; \
	ls -l ext/*.yml

all: key
	abuild -r

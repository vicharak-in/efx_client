install-serv:
	cp efx_ser /usr/local/bin/efx_ser

install-client:
	cp efx_client /usr/local/bin/efx_client
	cp efx_parse /usr/local/bin/efx_parse

uninstall:
	rm -f /usr/local/bin/efx_ser
	rm -f /usr/local/bin/efx_client
	rm -f /usr/local/bin/efx_parse

clean:
	rm -f /usr/local/bin/efx_ser
	rm -f /usr/local/bin/efx_client
	rm -f /usr/local/bin/efx_parse

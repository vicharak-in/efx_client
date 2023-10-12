install-serv:
	ln -sf `pwd`/efx_serv.sh /usr/bin/efx_serv.sh

install-client:
	ln -sf `pwd`/efx_client.sh /usr/bin/efx_client.sh

clean:
	rm -f /usr/bin/efx_serv.sh
	rm -f /usr/bin/efx_client.sh

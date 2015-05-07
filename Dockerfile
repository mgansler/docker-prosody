FROM debian:jessie
MAINTAINER martin@martingansler.de

ENV DEBIAN_FRONTEND noninteractive

ADD	http://packages.prosody.im/debian/pool/main/p/prosody-0.10/prosody-0.10_1nightly133-1~jessie_amd64.deb /tmp/

RUN	apt-get update && apt-get install --yes \
	lua5.1 \
	lua-dbi-mysql \
	lua-dbi-postgresql \
	lua-socket \
	lua-event \
	lua-sec \
	lua-zlib \
	libidn11 \
	liblua5.1-expat0 \
	liblua5.1-filesystem0 \
	ca-certificates

RUN	dpkg -i /tmp/prosody-0.10_1nightly*~jessie_amd64.deb && service prosody stop

RUN	apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
VOLUME ["/etc/prosody"]

EXPOSE 5222 5269
CMD [ "prosodyctl", "start" ]

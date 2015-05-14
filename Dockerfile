FROM debian:jessie
MAINTAINER martin@martingansler.de

ENV DEBIAN_FRONTEND noninteractive

COPY assets/ /assets
RUN 	echo deb http://packages.prosody.im/debian jessie main | tee -a /etc/apt/sources.list \
		&& apt-key add /assets/prosody-debian-packages.key \
		&& apt-get update \
		&& apt-get install --yes ca-certificates prosody lua-zlib lua-dbi-postgresql lua-dbi-mysql \
		&& service prosody stop \
		&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
VOLUME ["/etc/prosody"]

EXPOSE 5222 5269 5280 5281
CMD [ "prosodyctl", "start" ]

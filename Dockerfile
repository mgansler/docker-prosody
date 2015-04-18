FROM ubuntu
MAINTAINER martin@martingansler.de

ENV DEBIAN_FRONTEND noninteractive

COPY assets/ /assets
RUN 	echo deb http://packages.prosody.im/debian $(lsb_release -sc) main | tee -a /etc/apt/sources.list \
	&& apt-key add /assets/prosody-debian-packages.key \
	&& apt-get update \
	&& apt-get install --yes ca-certificates prosody lua-zlib \
	&& apt-get install --yes --no-install-recommends mercurial \
	&& service prosody stop
    
WORKDIR /usr/lib/
RUN hg clone https://code.google.com/p/prosody-modules/

VOLUME ["/etc/prosody"]
VOLUME ["/var/lib/prosody"]

EXPOSE 5222 5269
CMD [ "prosodyctl", "start" ]
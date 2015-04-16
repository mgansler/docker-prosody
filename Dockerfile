FROM ubuntu
MAINTAINER martin@martingansler.de

ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get update \
	&& apt-get install --yes prosody mercurial \
	&& service prosody stop \
	&& mkdir /run/prosody \
	&& chown prosody:adm /run/prosody
    
WORKDIR /usr/lib/
RUN hg clone https://code.google.com/p/prosody-modules/

VOLUME ["/etc/prosody"]
VOLUME ["/var/lib/prosody"]

EXPOSE 5222 5269
CMD [ "prosodyctl", "start" ]
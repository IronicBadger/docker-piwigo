FROM lsiobase/alpine.nginx:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
ARG PIWIGO_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	imagemagick \
	lynx \
	php7-apcu \
	php7-cgi \
	php7-dom \
	php7-exif \
	php7-gd \
	php7-imagick \
	php7-mysqli \
	php7-mysqlnd \
	php7-pear \
	php7-xmlrpc \
	php7-xsl \
	re2c \
	unzip \
	wget && \
 echo "**** set version tag ****" && \
 if [ -z ${PIWIGO_RELEASE+x} ]; then \
	PIWIGO_RELEASE=$(curl -sX GET "https://api.github.com/repos/Piwigo/Piwigo/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 echo ${PIWIGO_RELEASE} > /version.txt


# copy local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config /pictures

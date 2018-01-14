FROM alpine:3.7

MAINTAINER yinfuyuan <yinfuyuan@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S mysql && adduser -S -G mysql mysql

# grab su-exec for easy step-down from root
RUN apk add --no-cache 'su-exec>=0.2'

#RUN mkdir /docker-entrypoint-initdb.d

ENV MARIADB_MAJOR="10.2" \
    MARIADB_VERSION="10.2.12"

ENV MARIADB_DOWNLOAD_URL="http://mirrors.neusoft.edu.cn/mariadb//mariadb-${MARIADB_VERSION}/source/mariadb-${MARIADB_VERSION}.tar.gz"

RUN set -x; \
    \
	apk add --no-cache --virtual .build-deps \
        cmake \
        make \
        gcc \
        g++ \
        linux-headers \
        gnutls-dev \
        ncurses-dev \
        jemalloc-dev \
        libexecinfo-dev; \
    \
    wget -O mariadb-${MARIADB_VERSION}.tar.gz "${MARIADB_DOWNLOAD_URL}"; \
    \
    mkdir -p /usr/src; \
    tar -xzf mariadb-${MARIADB_VERSION}.tar.gz -C /usr/src; \
    rm mariadb-${MARIADB_VERSION}.tar.gz; \
    \
    cd /usr/src/mariadb-${MARIADB_VERSION}; \
    cmake . \
        -DWITHOUT_TOKUDB=1 \
        -DWITH_DEBUG=0; \
    \
    make; \
    make install; \
    rm -r /usr/src/mariadb-${MARIADB_VERSION}; \
    \
    apk del .build-deps

#EXPOSE 3306
#CMD ["mysqld"]

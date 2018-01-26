FROM alpine:3.7

MAINTAINER yinfuyuan <yinfuyuan@gmail.com>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -S mysql && adduser -S -G mysql mysql

ENV MARIADB_MAJOR="10.2" \
    MARIADB_VERSION="10.2.12" \
    MARIADB_HOME="/usr/local/mysql" \
    MYSQL_HOME="/usr/local/mysql"

ENV PATH=$PATH:${MYSQL_HOME}/bin \
    MARIADB_DOWNLOAD_URL="http://mirrors.neusoft.edu.cn/mariadb//mariadb-${MARIADB_VERSION}/source/mariadb-${MARIADB_VERSION}.tar.gz" \
    MARIADB_DOWNLOAD_SHA="2ab22d7fbacfabc30fe18f71a8afb173250074502d889457e3cde2e203d341ec"

RUN set -x; \
    \
    apk add --no-cache gnutls-dev; \
    \
	apk add --no-cache --virtual .build-deps \
        cmake \
        make \
        gcc \
        g++ \
        linux-headers \
        ncurses-dev \
        jemalloc-dev \
        libexecinfo-dev; \
    \
    wget -O mariadb-${MARIADB_VERSION}.tar.gz "${MARIADB_DOWNLOAD_URL}"; \
    \
    echo "${MARIADB_DOWNLOAD_SHA} mariadb-${MARIADB_VERSION}.tar.gz" | sha256sum -c -; \
    \
    mkdir -p /usr/src; \
    tar -xzf mariadb-${MARIADB_VERSION}.tar.gz -C /usr/src; \
    rm mariadb-${MARIADB_VERSION}.tar.gz; \
    \
    cd /usr/src/mariadb-${MARIADB_VERSION}; \
    cmake . \
        -DCMAKE_BUILD_TYPE=MinSizeRel \
        -DINSTALL_MYSQLTESTDIR= \
        -DWITH_MARIABACKUP=OFF \
        -DWITHOUT_TOKUDB=1; \
    \
    make; \
    make install; \
    rm -r /usr/src/mariadb-${MARIADB_VERSION}; \
    \
    apk del .build-deps

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]
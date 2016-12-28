FROM debian:latest

COPY . /src/

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y cmake make gcc g++ pkg-config \
        libmysqlclient-dev libssl-dev libreadline-gplv2-dev zlib1g-dev \
        libncurses5-dev libbz2-dev libpthread-workqueue-dev lbzip2 wget \
    && ln -s /lib/x86_64-linux-gnu/ /usr/lib64 \
    && ln -s /lib/x86_64-linux-gnu/librt.so.1 /lib64/ \
    && wget http://download.dre.vanderbilt.edu/previous_versions/ACE-6.0.3.tar.bz2 \
    && tar -xf ACE-6.0.3.tar.bz2 && mkdir /ACE_wrappers/_build \
    && cd /ACE_wrappers/_build \
    && ../configure --enable-ssl=no \
    && make && make install \
    && cd / && rm -rf /ACE_wrappers \
    && rm -f ACE-6.0.3.tar.bz2 \
    && mkdir -p /src/_build \
    && cd /src/_build \
    && cmake .. -Wno-dev -DPREFIX=/tc \
        -DOPENSSL_SSL_LIBRARIES=/usr/lib/x86_64-linux-gnu/libssl.so \
        -DOPENSSL_CRYPTO_LIBRARIES=/usr/lib/x86_64-linux-gnu/libcrypto.so \
        -DREADLINE_LIBRARY=/lib/x86_64-linux-gnu/libreadline.so.5 \
        -DBZIP2_LIBRARIES=/usr/lib/x86_64-linux-gnu/libbz2.so \
        -DZLIB_LIBRARY=/usr/lib/x86_64-linux-gnu/libz.so \
        -DWITH_WARNINGS=0 \
        -DWITH_COREDEBUG=0 \
        -DUSE_COREPCH=1 \
        -DUSE_SCRIPTPCH=1 \
        -DNOJEM=1 \
        -DTOOLS=0 \
        -DSCRIPTS=1 \
        -DNOJEM=0 \
        -DCMAKE_BUILD_TYPE=RelWithDebInfo \
        -DCMAKE_CXX_FLAGS="-std=c++11 -g -m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -pipe -fno-strength-reduce -fno-delete-null-pointer-checks -fno-strict-aliasing" \
        -DCMAKE_C_FLAGS="-g -m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -pipe -fno-strength-reduce -fno-delete-null-pointer-checks -fno-strict-aliasing" \
    && make -j8 && make install \
    && cd / \
    && rm -rf /src \
    && rm -rf /tc/etc/* \
    && rm -rf /tc/bin/authserver* \
    && apt-get remove -y --purge cmake make gcc g++ pkg-config libssl-dev \
        libmysqlclient-dev libreadline-gplv2-dev zlib1g-dev libncurses5-dev \
        libbz2-dev libpthread-workqueue-dev lbzip2 wget \
    && apt-get autoremove -y --purge

RUN apt-get install -y libmysqlclient18 libssl1.0.0 libreadline5 zlib1g \
    libncurses5 libbz2-1.0 libpthread-workqueue0

RUN mkdir -p /tc/logs && mkdir -p /tc/data && mkdir -p /var/core

WORKDIR /tc/bin

EXPOSE 8085 7878
VOLUME ["/tc/logs", "/tc/data", "/tc/etc"]
CMD ["/tc/bin/worldserver"]

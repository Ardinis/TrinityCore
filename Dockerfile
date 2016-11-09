FROM debian:latest

COPY . /src/

RUN apt-get update; \
    apt-get dist-upgrade -y; \
    apt-get install -y cmake make git-core gcc g++ pkg-config \
    libmysqlclient-dev libssl-dev libreadline-gplv2-dev zlib1g-dev \
    libncurses5-dev libbz2-dev libpthread-workqueue-dev lbzip2 wget

RUN ln -s /lib/x86_64-linux-gnu/ /usr/lib64; \
    ln -s /lib/x86_64-linux-gnu/librt.so.1 /lib64/

RUN wget http://download.dre.vanderbilt.edu/previous_versions/ACE-6.0.3.tar.bz2
RUN tar -xf ACE-6.0.3.tar.bz2 && mkdir /ACE_wrappers/_build

WORKDIR /ACE_wrappers/_build
RUN ../configure --enable-ssl=no
RUN make -j8 && make install
RUN rm -rf /ACE_wrappers

RUN mkdir -p /src/_build

WORKDIR /src/_build

RUN cmake .. -Wno-dev -DPREFIX=/tc \
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
    -DCMAKE_C_FLAGS="-g -m64 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -pipe -fno-strength-reduce -fno-delete-null-pointer-checks -fno-strict-aliasing"

RUN make -j8 && make install

WORKDIR /
RUN rm -rf /src; \
    rm -f /tc/etc/*; \
    rm -f /tc/bin/authserver*; \
    apt-get remove -fy --purge git-core build-essential gcc g++ \
    pkg-config libssl-dev libreadline-gplv2-dev zlib1g-dev libncurses5-dev \
    libbz2-dev libpthread-workqueue-dev libace-dev lbzip2 wget; \
    apt-get autoremove -y --purge

RUN apt-get install -y libmysqlclient18 libssl1.0.0 libreadline5 zlib1g \
    libncurses5 libbz2-1.0 libpthread-workqueue0

RUN mkdir -p /tc/logs && mkdir -p /tc/data && mkdir -p /var/core

WORKDIR /tc
ENTRYPOINT ["/tc/bin/worldserver"]

EXPOSE 8085 7878

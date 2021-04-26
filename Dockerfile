# docker build . -t modicn/systemsapproach:builder && docker push modicn/systemsapproach:builder

FROM python:3-alpine

ENV PATH="/usr/local/texlive/2021/bin/x86_64-linuxmusl:${PATH}"

COPY texlive.profile /

RUN set -ex; \
    apk update; \
    apk add --no-cache \
        curl \
        perl \
        freetype \
        fontconfig \
    ; \
    rm -rf /var/cache/apk/*; \
    mkdir /tmp/install-tl; \
    wget -q -O /tmp/install-tl/install-tl-unx.tar.gz http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
    tar -xzf /tmp/install-tl/install-tl-unx.tar.gz -C /tmp/install-tl --strip-components=1; \
    /tmp/install-tl/install-tl -profile /texlive.profile; \
    tlmgr install \
        capt-of \
        collection-fontsrecommended \
        fncychap \
        framed \
        latexmk \
        needspace \
        tabulary \ 
        titlesec \
        upquote \
        varwidth \
        wrapfig \
    ; \
    rm -rf /tmp/install-tl

COPY requirements.txt /

RUN set -ex; \
    apk update; \
    apk add --no-cache --virtual build-deps \
        build-base \
        libjpeg-turbo-dev \
        zlib-dev \
    ; \
    /usr/local/bin/python -m pip install --upgrade pip; \
    pip install --no-cache-dir -r /requirements.txt; \
    apk del build-deps; \
    apk add --no-cache \
        libjpeg-turbo \
        make \
    ; \
    rm -rf /var/cache/apk/*


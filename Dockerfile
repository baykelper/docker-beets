FROM library/alpine:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thetarkus"

RUN \
  \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    cmake \
    ffmpeg-dev \
    g++ \
    gcc \
    git \
    jpeg-dev \
    libpng-dev \
    make \
    mpg123-dev \
    openjpeg-dev \
    libxml2-dev \
    libxslt-dev \
    python3-dev && \
  \
  \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    curl \
    expat \
    ffmpeg \
    ffmpeg-libs \
    gdbm \
    gst-plugins-good \
    gstreamer \
    jpeg \
    lame \
    libffi \
    libpng \
    mpg123 \
    nano \
    openjpeg \
    py3-gobject3 \
    py3-pip \
    python3 \
    sqlite-libs \
    tar \
    wget && \
  \
  \
  echo "**** compile mp3gain ****" && \
  mkdir -p /tmp/mp3gain-src && \
  curl -o /tmp/mp3gain-src/mp3gain.zip -L https://sourceforge.net/projects/mp3gain/files/mp3gain/1.6.2/mp3gain-1_6_2-src.zip && \
  cd /tmp/mp3gain-src && \
  unzip -qq /tmp/mp3gain-src/mp3gain.zip && \
  sed -i "s#/usr/local/bin#/usr/bin#g" /tmp/mp3gain-src/Makefile && \
  make && make install && \
  \
  \
  echo "**** compile chromaprint ****" && \
  git clone https://bitbucket.org/acoustid/chromaprint.git /tmp/chromaprint && \
  cd /tmp/chromaprint && \
  cmake \
    -DBUILD_TOOLS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr && \
  make && make install && \
  \
  \
  echo "**** install pip packages ****" && \
  pip3 install --no-cache-dir -U \
    beautifulsoup4 \
    git+https://github.com/beetbox/beets \
    beets-copyartifacts \
    discogs-client \
    gmusicapi \
    flask \
    pillow \
    pip \
    pyacoustid \
    pylast \
    requests \
    unidecode && \
  \
  \
  echo "**** create user ****" && \
  addgroup -S beets && \
  adduser --shell /bin/sh -S beets -G beets && \
  \
  \
  echo "**** cleanup ****" && \
  apk del --purge build-dependencies && \
  rm -rf \
    /root/.cache \
    /tmp/*

# environment settings
ENV BEETSDIR="/config" \
EDITOR="nano" \
HOME="/config"

# copy local files
COPY files/ /

# ports and volumes
EXPOSE 8337
VOLUME /config /downloads /music

# entrypoint
CMD ["/init.sh"]

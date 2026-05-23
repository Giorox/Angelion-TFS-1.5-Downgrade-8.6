FROM ubuntu:24.04 AS build
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get --assume-yes install \
  cmake \
  build-essential \
  libluajit-5.1-dev \
  libmysqlclient-dev \
  libboost-system-dev \
  libboost-iostreams-dev \
  libpugixml-dev \
  libcrypto++-dev \
  libfmt-dev \
  libboost-filesystem-dev \
  libboost-date-time-dev

COPY cmake /usr/src/forgottenserver/cmake/
COPY src /usr/src/forgottenserver/src/
COPY CMakeLists.txt CMakePresets.json /usr/src/forgottenserver/
WORKDIR /usr/src/forgottenserver
RUN mkdir build
WORKDIR /usr/src/forgottenserver/build
RUN cmake .. && make

FROM ubuntu:24.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
  apt-get --assume-yes install \
  tzdata \
  libluajit-5.1-dev \
  libmysqlclient-dev \
  libboost-system-dev \
  libboost-iostreams-dev \
  libpugixml-dev \
  libcrypto++-dev \
  libfmt-dev \
  libboost-filesystem-dev \
  libboost-date-time-dev

COPY --from=build /usr/src/forgottenserver/build/tfs /bin/tfs
COPY data /srv/data/
COPY config.lua LICENSE README.md *.sql key.pem /srv/

EXPOSE 7171 7172
WORKDIR /srv
VOLUME /srv
ENTRYPOINT ["/bin/tfs"]
FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y && apt install -y --no-install-recommends \
  git \
  build-essential \
  ninja-build \
  python3-pip \
  python3-setuptools \
  pkg-config \
  libpng-dev \
  libcairo2-dev && \
  pip3 install wheel && \
  pip3 install meson && \
  git clone https://gitlab.com/mildlyparallel/pscircle && \
  cd /pscircle && \
  sed -i 's/\"\/proc/\"\/host\/proc/g' src/proc_linux.c && \
  mkdir build && cd build && \
  meson .. && \
  meson configure -Denable-x11=false && \
  ninja && \
  ninja install && \
  apt-get clean

USER nobody

ENTRYPOINT ["pscircle"]
CMD ["--help"]

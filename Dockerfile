FROM ubuntu:bionic

# This removes some warning when installing packages when there is no X
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --yes\
  libssl-dev \
  pkg-config \
  cmake\
  zlib1g-dev \
  curl \
  qt5-default \
  python2.7 \
  gosu \
  git \
  wget

WORKDIR /hc

RUN wget https://github.com/holochain/holochain-rust/releases/download/v0.0.12-alpha1/cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz

RUN tar xvfz cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz

#RUN echo 'alias hc="/hc/cli-v0.0.12-alpha1-x86_64-unknown-linux-gnu/hc"' >> ~/.profile

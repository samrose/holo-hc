FROM ubuntu:bionic

# This removes some warning when installing packages when there is no X
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --yes\
  libssl-dev \
  pkg-config \
  cmake\
  zlib1g-dev \
  curl \
  python2.7 \
  gosu \
  git \
  wget \
  file \
  build-essential
WORKDIR /hc

RUN wget https://github.com/holochain/holochain-rust/releases/download/v0.0.12-alpha1/cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz

RUN tar xvfz cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz

RUN curl https://sh.rustup.rs -s > /home/install.sh && \
    chmod +x /home/install.sh && \
    sh /home/install.sh -y --verbose --default-toolchain nightly-2019-01-24

ENV PATH "/root/.cargo/bin:$PATH"

RUN rustup target add wasm32-unknown-unknown --toolchain nightly-2019-01-24

#RUN echo 'alias hc="/hc/cli-v0.0.12-alpha1-x86_64-unknown-linux-gnu/hc"' >> ~/.profile

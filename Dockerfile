FROM circleci/golang:1.12
RUN ls -la /home
# This removes some warning when installing packages when there is no X
ENV DEBIAN_FRONTEND noninteractive

RUN sudo  apt-get update && sudo apt-get install --yes\
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
WORKDIR /home/circleci

RUN sudo wget https://github.com/holochain/holochain-rust/releases/download/v0.0.12-alpha1/cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz

RUN sudo tar xvfz cli-v0.0.12-alpha1-x86_64-generic-linux-gnu.tar.gz
RUN mkdir -p /home/circleci/rustup
RUN curl https://sh.rustup.rs -s > /home/circleci/rustup/install.sh && \
    chmod +x /home/circleci/rustup/install.sh && \
    sh /home/circleci/rustup/install.sh -y --verbose --default-toolchain nightly-2019-01-24

ENV PATH "/home/circleci/.cargo/bin:$PATH"

RUN rustup target add wasm32-unknown-unknown --toolchain nightly-2019-01-24

#RUN echo 'alias hc="/hc/cli-v0.0.12-alpha1-x86_64-unknown-linux-gnu/hc"' >> ~/.profile

RUN go get github.com/tcnksm/ghr

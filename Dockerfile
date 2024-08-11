FROM ubuntu:20.04

RUN apt update -qq && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    git curl ca-certificates libgtk-3-0 libglib2.0-0 libxss1 libasound2 libnss3 \
    libdrm2 libgbm1 libx11-xcb1 \
    && apt clean -y && rm -rf /var/lib/apt/lists/* \
    && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash \
    && . ~/.nvm/nvm.sh && nvm install v16.20.2 && npm install -g electron-packager

COPY entrypoint.sh .
ARG tag=master
RUN git clone --depth 1 --branch ${tag} https://github.com/BloodHoundAD/BloodHound.git \
    && cd BloodHound && . ~/.nvm/nvm.sh && npm install --legacy-peer-deps && npm run build:linux

ENTRYPOINT ["/entrypoint.sh"]
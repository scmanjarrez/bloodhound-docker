FROM node:16.20-bullseye AS build
ARG tag=master
RUN apt update -qq && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    git curl && npm install -g electron-packager \
    && git clone --depth 1 --branch ${tag} https://github.com/BloodHoundAD/BloodHound.git \
    && cd BloodHound && npm install && npm run build:linux

FROM debian:11-slim
RUN apt update -qq && DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends \
    libasound2 libx11-xcb1 libxss1 libnss3 libgtk-3-0 libglib2.0-0 libdrm2 libgbm1  \
    && apt clean -y && rm -rf /var/lib/apt/lists/*
COPY --from=build /BloodHound/BloodHound-linux-x64/ /BloodHound
COPY --from=build /BloodHound/Collectors/ /Ingestors
COPY entrypoint.sh .

ENTRYPOINT ["/entrypoint.sh"]

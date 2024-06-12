FROM debian:12-slim as builder

ARG ZTM_VERSION

RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /ztm
RUN curl -sL https://github.com/flomesh-io/ztm/releases/download/v${ZTM_VERSION}/ztm-aio-v${ZTM_VERSION}-generic_linux-x86_64.tar.gz \
    | tar -xz

FROM debian:12-slim

ARG ZTM_VERSION

ENV ZTM_VERSION=${ZTM_VERSION}
ENV LISTEN=127.0.0.1:7777
ENV DATABASE=/home/ztm/.ztm.db

RUN useradd -m -d /home/ztm ztm
RUN chown -R ztm:ztm /home/ztm

COPY --from=builder bin/ztm /usr/local/bin/ztm
RUN chmod +x /usr/local/bin/ztm

WORKDIR /home/ztm

USER ztm

ENTRYPOINT sh -c "/usr/local/bin/ztm run agent --listen ${LISTEN} --database ${DATABASE}"
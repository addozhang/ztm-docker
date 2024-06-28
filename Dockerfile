FROM debian:12-slim AS builder

ARG TARGETARCH
ARG ZTM_VERSION

RUN apt-get update && apt-get install -y curl tar && rm -rf /var/lib/apt/lists/*
RUN ARCH=$TARGETARCH && \
    if [ "$TARGETARCH" = "amd64" ]; then \
    ARCH="x86_64"; \
    fi && \
    mkdir -p /ztm && \
    curl -sL https://github.com/flomesh-io/ztm/releases/download/v${ZTM_VERSION}/ztm-aio-v${ZTM_VERSION}-generic_linux-${ARCH}.tar.gz \
    | tar -xz -C /ztm

RUN ls -l /ztm/bin/ztm && \
    chmod +x /ztm/bin/ztm

FROM debian:12-slim

RUN useradd -m -d /home/ztm ztm && \
    chown -R ztm:ztm /home/ztm

COPY --from=builder /ztm/bin/ztm /usr/local/bin/ztm
RUN chmod +x /usr/local/bin/ztm

WORKDIR /home/ztm
USER ztm

# Entrypoint to start the services
ENTRYPOINT ["/usr/local/bin/ztm"]
CMD ["run", "agent", "--database", "/home/ztm/.ztm-ca.db"]

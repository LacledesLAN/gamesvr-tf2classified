FROM lacledeslan/steamcmd AS tf2class-builder

ARG SKIP_STEAMCMD=false

# Copy cached build files (if any)
# TODO!

# Download TF2 Classified Dedicated Server
RUN mkdir --parents /output && \
    /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 3557020 validate +quit;



#-------
FROM lacledeslan/gamesvr-tf2:base-latest

ARG BUILD_NODE=unspecified
ARG GIT_REVISION=unspecified

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

HEALTHCHECK NONE

LABEL architecture="amd64" \
    com.lacledeslan.build-node=$BUILD_NODE \
    maintainer="Laclede's LAN <contact@lacledeslan.com>" \
    org.opencontainers.image.description="Team Fortress 2 Classified Dedicated Server" \
    org.opencontainers.image.revision=$GIT_REVISION \
    org.opencontainers.image.source="https://github.com/LacledesLAN/gamesvr-tf2classified" \
    org.opencontainers.image.vendor="Laclede's LAN"

COPY --chown=TF2:root --from=tf2class-builder /output /app/tf2c

COPY ./dist/libtinfo.5_6.4.4/amd64/lib/x86_64-linux-gnu/libtinfo.so.5.9 /lib/x86_64-linux-gnu/libtinfo.so.5

RUN dpkg --add-architecture i386 && \
    apt-get update && \
        apt-get install -y \
            lib32gcc-s1 lib32stdc++6 \
            --no-install-recommends --no-install-suggests --no-upgrade && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
    # Symlink the Steam client library from the TF2 installation to the TF2 Classified installation
    mkdir -p /app/tf2c/.steam/sdk64/ && \
        ln -sf /app/tf2/.steam/sdk64/steamclient.so /app/tf2c/.steam/sdk64/steamclient.so && \
        test -L /app/tf2c/.steam/sdk64/steamclient.so && \
    # Update username, home directory, and permissions for the TF2 Classified user
    usermod -l TF2classified TF2 && \
    usermod -d /app/tf2c/ TF2classified && \
    mkdir -p /app/tf2c/logs && \
    chmod 774 /app/tf2c/logs;

USER TF2classified

WORKDIR /app/tf2c/

CMD ["/bin/bash"]

ONBUILD USER root

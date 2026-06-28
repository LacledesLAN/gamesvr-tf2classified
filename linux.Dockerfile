FROM lacledeslan/steamcmd AS tf2class-builder

ARG SKIP_STEAMCMD=false

# Copy cached build files (if any)
# TODO!

# Download TF2 Classified Dedicated Server
RUN mkdir --parents /output && \
    /app/steamcmd.sh +force_install_dir /output +login anonymous +app_update 3557020 validate +quit;

COPY ./dist/linux-x64 /output


#-------
FROM lacledeslan/gamesvr-tf2:base-latest

ARG BUILDNODE=unspecified
ARG SOURCE_COMMIT=unspecified

ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

HEALTHCHECK NONE

LABEL maintainer="Laclede's LAN <contact @lacledeslan.com>" \
      com.lacledeslan.build-node=$BUILDNODE \
      org.label-schema.schema-version="1.0" \
      org.label-schema.url="https://github.com/LacledesLAN/README.1ST" \
      org.label-schema.vcs-ref=$SOURCE_COMMIT \
      org.label-schema.vendor="Laclede's LAN" \
      org.label-schema.description="Team Fortress 2 Classified Dedicated Server" \
      org.label-schema.vcs-url="https://github.com/LacledesLAN/gamesvr-tf2classified" \
      architecture="amd64"

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y lib32gcc-s1 lib32stdc++6 libncurses6:i386 libtinfo6:i386 && \
    rm -rf /var/lib/apt/lists/*

COPY --chown=TF2:root --from=tf2class-builder /output /app/tf2c

# UPDATE USERNAME & ensure permissions
RUN usermod -l TF2classified TF2 && \
    usermod -d /app/tf2c/ TF2classified && \
    chmod +x /app/tf2c/ll-tests/*.sh && \
    mkdir -p /app/tf2c/logs/ && \
    chmod 774 /app/tf2c/logs/

USER TF2classified

WORKDIR /app/tf2c/

CMD ["/bin/bash"]

ONBUILD USER root

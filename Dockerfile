FROM alpine:3.19

RUN apk update && apk add --no-cache \
    curl \
    git \
    sudo \
    shadow \
    python3 \
    && rm -rf /var/cache/apk/* \
    && adduser -D -h /home/dev -s /bin/sh dev \
    && adduser dev wheel \
    && echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel \
    && passwd -ed dev \
    && chown -R dev:dev /home/dev

USER dev
WORKDIR /home/dev
COPY --chown=dev:dev .profile .profile
COPY --chown=dev:dev .installers.sh .installers.sh
ENV ENV ~/.profile

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "while true; do sleep 3600; done" ]

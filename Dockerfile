FROM alpine:3.19

RUN apk update && apk add --no-cache \
    bash \
    curl \
    git \
    sudo \
    shadow \
    python3 \
    && rm -rf /var/cache/apk/* \
    && adduser -D -h /home/dev -s /bin/bash dev \
    && adduser dev wheel \
    && echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/wheel \
    && passwd -ed dev \
    && echo 'function install-awscli() { ' >> /home/dev/.bashrc \
    && echo '  sudo apk update;' >> /home/dev/.bashrc \
    && echo '  sudo apk add aws-cli;' >> /home/dev/.bashrc \
    && echo '}' >> /home/dev/.bashrc \
    && echo 'function install-opentofu() { ' >> /home/dev/.bashrc \
    && echo '  sudo apk update;' >> /home/dev/.bashrc \
    && echo '  sudo apk add opentofu;' >> /home/dev/.bashrc \
    && echo '}' >> /home/dev/.bashrc \
    && echo 'function install-azure-cli() {' >> /home/dev/.bashrc \
    && echo '  sudo apk update;' >> /home/dev/.bashrc \
    && echo '  sudo apk add --no-cache --virtual build-deps \' >> /home/dev/.bashrc \
    && echo '    py3-pip gcc python3-dev musl-dev linux-headers;' >> /home/dev/.bashrc \
    && echo '  pip install azure-cli --no-cache-dir --break-system-packages --no-warn-script-location;' >> /home/dev/.bashrc \
    && echo '  sudo apk del build-deps;' >> /home/dev/.bashrc \
    && echo '  echo "export PATH=$PATH:$HOME/.local/bin" >> /home/dev/.bashrc' >> /home/dev/.bashrc \
    && echo '}' >> /home/dev/.bashrc \
    && echo 'function install-gcloud() { ' >> /home/dev/.bashrc \
    && echo '  curl -sSL https://sdk.cloud.google.com | bash;'  >> /home/dev/.bashrc \
    && echo '  echo "source $HOME/google-cloud-sdk/path.bash.inc" >> $HOME/.bashrc;'  >> /home/dev/.bashrc \
    && echo '  echo "source $HOME/google-cloud-sdk/completion.bash.inc" >> $HOME/.bashrc;'  >> /home/dev/.bashrc \
    && echo '  source $HOME/.bashrc' >> /home/dev/.bashrc \
    && echo '}' >> /home/dev/.bashrc \
    && echo 'function install-k8s-tools() { ' >> /home/dev/.bashrc \
    && echo '  sudo apk update;' >> /home/dev/.bashrc \
    && echo '  sudo apk add --no-cache \' >> /home/dev/.bashrc \
    && echo '    kubectl kubectl-bash-completion helm helm-bash-completion kubectx k9s' >> /home/dev/.bashrc \
    && echo '}' >> /home/dev/.bashrc \
    && echo '[[ $(chage -l dev | head -1 | cut -d " " -f 4-8) = "password must be changed" ]] && passwd dev' >> /home/dev/.bashrc \
    && chown -R dev:dev /home/dev

USER dev
WORKDIR /home/dev

ENTRYPOINT [ "/bin/bash" ]
CMD [ "-c", "while true; do sleep infinity; done" ]

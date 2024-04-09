#! /bin/sh

install_awscli()
{
  sudo apk update
  sudo apk add --no-cache aws-cli
}

install_opentofu()
{
  sudo apk update
  sudo apk add --no-cache opentofu
}

install_azure_cli()
{
  grep -q "^export PATH=$PATH:$HOME/.local/bin$" /home/dev/.profile || \
    echo "export PATH=\$PATH:\$HOME/.local/bin" >> /home/dev/.profile
  sudo apk update
  sudo apk add --no-cache --virtual build-deps \
    py3-pip gcc python3-dev musl-dev linux-headers
  pip install azure-cli --no-cache-dir --break-system-packages --no-warn-script-location
  sudo apk del build-deps
  source /home/dev/.profile
}

install_gcloud()
{
  sudo apk add --no-cache --virtual build bash
  curl -sSL https://sdk.cloud.google.com | bash
  source $HOME/.profile
  sudo apk del build
}

install_k8s_tools()
{
  sudo apk update
  sudo apk add --no-cache \
    kubectl helm kubectx k9s
}

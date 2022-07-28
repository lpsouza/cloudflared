#!/bin/bash

ARCH=$(uname -m)

case $ARCH in
  x86_64)
    DEBPKG="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb"
    ;;
  aarch64)
    DEBPKG="https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb"
    ;;
  *)
    echo "Error: Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

wget -O cloudflared.deb $DEBPKG
dpkg -i cloudflared.deb
rm cloudflared.deb

if [ "$#" -ne 0 ]; then
  cloudflared $*
  exit 1
fi

cloudflared tunnel --config /root/.cloudflared/config.yaml run

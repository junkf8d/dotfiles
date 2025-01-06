#!/bin/bash

# sudoでなきゃ終わり
if [ "$EUID" -ne 0 ]; then
  echo " * Please run as root."
  exit 1
fi

# WSL Ubunutでなきゃ終わり
if ! (grep -qi microsoft /proc/version && grep -qi ubuntu /etc/os-release); then
  echo " * This script is only for WSL Ubuntu."
  exit 1
fi


# 必須パッケージをインストール
# sudo apt update
# sudo apt upgrade -y
sudo apt install jq wl-clipboard

echo " * Starting setup for WSL Ubuntu..."

ROOT=$(git rev-parse --show-toplevel)
source $ROOT/_common.sh

chmod +x ./setup/*.sh
for script in $ROOT/setup/*.sh; do
    if [ -f "$script" ]; then
        echo "---------- $(basename "$script")"
        "$script"
    else
        echo "スクリプトが見つかりません。"
    fi
done
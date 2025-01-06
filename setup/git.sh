ROOT=$(git rev-parse --show-toplevel)
source $ROOT/_common.sh

if ! grep -qr "git-core/ppa" /etc/apt/sources.list /etc/apt/sources.list.d/ 2>/dev/null; then
  sudo add-apt-repository ppa:git-core/ppa -y
  sudo apt update
  sudo apt install git -y
fi

if ! git config --get --global user.name; then
  git config --global user.name $(meta .git.user.name)
fi

if ! git config --get --global user.email; then
  git config --global user.email $(meta .git.user.email)
fi

git config --global core.editor $(meta .git.core.editor)
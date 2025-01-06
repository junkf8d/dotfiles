source $HOME/dotfiles/_common.sh

sudo add-apt-repository ppa:git-core/ppa -y
sudo apt update
sudo apt install git -y

if ! git config --get --global user.name; then
  git config --global user.name $(meta .git.user.name)
fi

if ! git config --get --global user.email; then
  git config --global user.email $(meta .git.user.email)
fi

git config --global core.editor $(meta .git.core.editor)
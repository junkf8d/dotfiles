chmod +x $HOME/dotfiles/.env
source $HOME/dotfiles/.env
source $HOME/dotfiles/_common.sh

if [ -z $GITHUB_TOKEN ]; then
  echo ".env に GITHUB_TOKEN が設定されてません。"
  exit 1
fi

user="$(git config --global user.email):$GITHUB_TOKEN"
title="$(hostname) $(grep '^PRETTY_NAME=' /etc/os-release | grep -oP '(?<=").+(?=")')"
file=$(meta .ssh.file | sed "s|~|$HOME|").pub

curl -u $user --data "{\"title\":\"$title\",\"key\":\"$(cat $file)\"}" https://api.github.com/user/keys

# if ! type -p gh >/dev/null; then
#     sudo mkdir -p -m 755 /etc/apt/keyrings
#     wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
#     sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
#     sudo apt update
#     sudo apt install gh -y
# fi
#gh ssh-key add ~/.ssh/id_ed25519.pub --title "My Laptop Key" --no-interactive
ROOT=$(git rev-parse --show-toplevel)
source $ROOT/_common.sh

chmod +x $ROOT/.env
source $ROOT/.env

$ROOT/setup/git.sh
$ROOT/setup/ssh-keygen.sh

HOME=$(echo $ROOT | grep -Po "/home/[^/]+")

if [ -z $GITHUB_TOKEN ]; then
  echo ".env に GITHUB_TOKEN が設定されてません。"
  exit 1
fi

if $(get_flag ".github_ssh_key_added"); then
  log "GitHubにSSHキーを追加済みなのでスキップ"
  exit
fi

user="$(git config --global user.email):$GITHUB_TOKEN"
title="$(hostname) $(grep '^PRETTY_NAME=' /etc/os-release | grep -oP '(?<=").+(?=")')"
file=$(meta .ssh.file | sed "s|~|$HOME|").pub

curl -u $user --data "{\"title\":\"$title\",\"key\":\"$(cat $file)\"}" https://api.github.com/user/keys

if [ $? -eq 0 ]; then
  set_flag ".github_ssh_key_added" "true"
else
  log "GitHubにSSHキーを追加しようとしたけど何か失敗しました"
fi


#curl -u $user https://api.github.com/user/keys

# ghでやる方法はとりあえずやらない
# if ! type -p gh >/dev/null; then
#     sudo mkdir -p -m 755 /etc/apt/keyrings
#     wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
#     sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
#     sudo apt update
#     sudo apt install gh -y
# fi
#gh ssh-key add ~/.ssh/id_ed25519.pub --title "My Laptop Key" --no-interactive
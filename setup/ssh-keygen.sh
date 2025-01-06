
source $HOME/dotfiles/_common.sh
file=$(meta .ssh.file | sed "s|~|$HOME|")

# SSHキーの生成
if [ ! -f $file ]; then
  # コメント、パスフレーズなし
  ssh-keygen -t ed25519 -C "$(date -Iseconds)" -N "" -f $file
fi
meta() {
    jq -r $1 $HOME/dotfiles/_meta.json
}

log() {
    echo "$(meta '.meta.prompt')$1"
}
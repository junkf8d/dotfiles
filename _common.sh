meta() {
    jq -r $1 $HOME/dotfiles/_meta.json
}

log() {
    echo "$(meta '.meta.prompt')$1"
}

get_flag(){
    jq -r $1 $HOME/dotfiles/.flags.json
}

set_flag(){
    # これでも出来るけどエラー出ると全部消えるからやらない
    #cat <<< $(jq "$1 |= \"$2\"" $HOME/dotfiles/.flags.json) > $HOME/dotfiles/.flags.json

    result=$(jq "$1 |= \"$2\"" $HOME/dotfiles/.flags.json)
    if [ $? -eq 0 ]; then
        echo $result > $HOME/dotfiles/.flags.json
    else
        echo " * json の書き換えに失敗しました: $1 = $2"
    fi
}
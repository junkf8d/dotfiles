# こんな感じ頑張ったらsourceしても使えた
# DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))
# けどもう疲れたから.gitがあるフォルダをルートフォルダとする
ROOT=$(git rev-parse --show-toplevel)

meta() {
    jq -r $1 $ROOT/_meta.json
}

log() {
    echo "$(meta '.meta.prompt')$1"
}

home(){
    # sudoするとHOMEが使えないので
    echo $(echo $ROOT | grep -Po "/home/[^/]+")
}

get_flag(){
    if [ -e $ROOT/.flags.json ]; then
        jq -r $1 $ROOT/.flags.json
    else
        echo "{}" > $ROOT/.flags.json
    fi
}

set_flag(){
    if [ -e $ROOT/.flags.json ]; then
        result=$(jq "$1 |= \"$2\"" $ROOT/.flags.json)
        if [ $? -eq 0 ]; then
            echo $result | jq "." > $ROOT/.flags.json
        else
            echo " * json の書き換えに失敗しました: $1 = $2"
        fi
    else
        echo "{}" > $ROOT/.flags.json
    fi
}
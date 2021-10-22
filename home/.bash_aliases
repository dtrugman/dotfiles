ta() {
    declare -r sessions=$(tmux ls)
    declare -r num=$(echo "$sessions" | wc -l)
    declare id=0
    if [[ $num -eq 1 ]]; then
        id=$(echo "$sessions" | awk '{ print $1 }')
    else
        echo "$sessions"
        read -p "Session? " id
    fi

    tmux attach -t $id
}

cls() {
    for _ in $(seq 0 100); do
        echo ""
    done
}

alias vissh="vim ~/.ssh/config"

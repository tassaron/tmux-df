#!/usr/bin/env bash

df_interpolations=(
    "\#{df_avail}"
    "\#{df_percent}"
)
df_interpolation_cmd=(
    "$(df -h | awk '{if ($6 == "/") {print $4}}')"
    "$(df -h | awk '{if ($6 == "/") {print $5}}')"
)

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value="$(tmux show-option -gqv "$option")"

    if [[ -z "$option_value" ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

set_tmux_option() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local result="$1"
    for ((i=0; i < ${#df_interpolations[@]}; i++)); do
        local cmd="${df_interpolation_cmd[$string]}"
	    result="${result//${df_interpolations[$i]}/${df_interpolation_cmd[$i]}}"
    done
    echo "$result" 
}

update_tmux_option() {
	local option=$1
	local option_value=$(get_tmux_option "$option")
	local new_option_value=$(do_interpolation "$option_value")
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main
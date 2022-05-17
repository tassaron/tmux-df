#!/usr/bin/env bash

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

DF_CMD_PRIVATE=(
    $(get_tmux_option "@df_cmd_private1" "/")
    $(get_tmux_option "@df_cmd_private2" "/")
    $(get_tmux_option "@df_cmd_private3" "/")
    $(get_tmux_option "@df_cmd_private4" "/")
    $(get_tmux_option "@df_cmd_private5" "/")
)

df_interpolations=(
    "\#{df_avail}"
    "\#{df_percent}"
    "\#{df_avail_private1}"
    "\#{df_percent_private1}"
    "\#{df_avail_private2}"
    "\#{df_percent_private2}"
    "\#{df_avail_private3}"
    "\#{df_percent_private3}"
    "\#{df_avail_private4}"
    "\#{df_percent_private4}"
    "\#{df_avail_private5}"
    "\#{df_percent_private5}"
)
df_interpolation_cmd=(
    "df -h / | awk '{print \$4}' | tail -n 1"
    "df -h / | awk '{print \$5}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[0]} | awk '{print \$4}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[0]} | awk '{print \$5}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[1]} | awk '{print \$4}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[1]} | awk '{print \$5}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[2]} | awk '{print \$4}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[2]} | awk '{print \$5}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[3]} | awk '{print \$4}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[3]} | awk '{print \$5}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[4]} | awk '{print \$4}' | tail -n 1"
    "df -h ${DF_CMD_PRIVATE[4]} | awk '{print \$5}' | tail -n 1"
)

set_tmux_option() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local result="$1"
    for ((i=0; i < ${#df_interpolations[@]}; i++)); do
        local cmd="${df_interpolation_cmd[$i]}"
        cmd="#(${cmd})"
	    result="${result//${df_interpolations[$i]}/${cmd}}"
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

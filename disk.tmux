#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/scripts/helpers.sh"

disk_interpolation=(
  "\#{disk_percentage}"
  "\#{disk_avail}"
  "\#{disk_fg_color}"
)
disk_commands=(
  "#($CURRENT_DIR/scripts/disk_percentage.sh)"
  "#($CURRENT_DIR/scripts/disk_avail.sh)"
  "#($CURRENT_DIR/scripts/disk_fg_color.sh)"
)

set_tmux_option() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

do_interpolation() {
  local all_interpolated="$1"
  for ((i = 0; i < ${#disk_commands[@]}; i++)); do
    all_interpolated=${all_interpolated//${disk_interpolation[$i]}/${disk_commands[$i]}}
  done
  echo "$all_interpolated"
}

update_tmux_option() {
  local option=$1
  local option_value
  local new_option_value
  option_value=$(get_tmux_option "$option")
  new_option_value=$(do_interpolation "$option_value")
  set_tmux_option "$option" "$new_option_value"
}

main() {
  update_tmux_option "status-right"
  update_tmux_option "status-left"
}
main

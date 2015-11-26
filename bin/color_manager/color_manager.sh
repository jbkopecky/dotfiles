#!/usr/bin/env bash

colo() {

    local colorscheme="$1"; shift
    local term_api="gnome"

    local api_file=./term_apis/"$term_api".sh
    local color_file=./colors/"$colorscheme".sh

    if [[ ! -f "$api_file" ]]; then
        echo "[ERROR] No colormanager API found for this terminal"
        return 0
    else
        source "$api_file"
    fi

    if [[ ! -f "$color_file" ]]; then
        echo "[ERROR] No colormanager colorscheme found"
        return 0
    else
        source "$color_file"
    fi

    modify_profile "$PALETTE" "$BG" "$FG" "$FG" "$PROFILE_SLUG"

}

# Main ==================================================================== {{{
colo gruvbox.dark
# }}}

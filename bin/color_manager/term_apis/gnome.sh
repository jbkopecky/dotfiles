#!/usr/bin/env bash

dset() { # {{{
    local key="$1"; shift
    local val="$1"; shift

    if [[ "$type" == "string" ]]; then
        val="'$val'"
    fi

    "$DCONF" write "$PROFILE_KEY/$key" "$val"
} # }}}

dlist_append() { # {{{

    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$DCONF" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
        } | head -c-1 | tr "\n" ,
    )"

    "$DCONF" write "$key" "[$entries]"
} # }}}

dconf_create_profile() { # {{{
    local palette="$1"; shift
    local bg_color="$1"; shift
    local fg_color="$1"; shift
    local bold_color="$1";shift
    local profile_name="$1"; shift
    local profile_slug="$1"; shift
    local key="$1"; shift
    local same_as_fg="true"
    local theme_colors="false"
    local theme_bg="false"

    # add new copy to list of profiles
    dlist_append $BASE_KEY_NEW/list $profile_slug

    # update profile values with theme options
    dset visible-name "$profile_name"
    dset palette "$palette"
    dset background-color "$bg_color"
    dset foreground-color "$fg_color"
    dset bold-color "$bold_color"
    dset bold-color-same-as-fg "$same_as_fg"
    dset use-theme-colors "$theme_colors"
    dset use-theme-background "$theme_bg"
} # }}}

gset() {  # {{{
    local type="$1"; shift
    local key="$1"; shift
    local val="$1"; shift

    "$GCONFTOOL" --set --type "$type" "$PROFILE_KEY/$key" -- "$val"
} # }}}

glist_append() { # {{{
    local type="$1"; shift
    local key="$1"; shift
    local val="$1"; shift

    local entries="$(
        {
            "$GCONFTOOL" --get "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
        } | head -c-1 | tr "\n" ,
    )"

    "$GCONFTOOL" --set --type list --list-type $type "$key" "[$entries]"
} # }}}

gconf_create_profile() { # {{{
    local palette="$1"; shift
    local bg_color="$1"; shift
    local fg_color="$1"; shift
    local bold_color="$1";shift
    local profile_name="$1"; shift
    local profile_slug="$1"; shift
    local key="$1"; shift
    local same_as_fg="true"
    local theme_colors="false"
    local theme_bg="false"

    glist_append string "$key" "$profile_slug"

    gset string visible_name "$profile_name"
    gset string palette "$palette"
    gset string background_color "$bg_color"
    gset string foreground_color "$fg_color"
    gset string bold_color "$bold_color"
    gset bool   bold_color_same_as_fg "$same_as_fg"
    gset bool   use_theme_colors "$theme_colors"
    gset bool   use_theme_background "$theme_bg"
} # }}}

create_profile(){ # {{{

    # gnome_create_profile palette bg_color fg_color bold_color profile_name profile_slug

    local pa="$1"; shift
    local bg="$1"; shift
    local fg="$1"; shift
    local bo="$1";shift
    local pn="$1";shift
    local ps="$1";shift

    [[ -z "$DCONF" ]] && DCONF=dconf
    [[ -z "$UUIDGEN" ]] && UUIDGEN=uuidgen

    # Newest versions of gnome-terminal use dconf
    if which "$DCONF" > /dev/null 2>&1; then
        [[ -z "$BASE_KEY_NEW" ]] && BASE_KEY_NEW=/org/gnome/terminal/legacy/profiles:

        if [[ -n "`$DCONF list $BASE_KEY_NEW/`" ]]; then
            if which "$UUIDGEN" > /dev/null 2>&1; then
                PROFILE_SLUG=`uuidgen`
            fi

            if [[ -n "`$DCONF read $BASE_KEY_NEW/default`" ]]; then
                DEFAULT_SLUG=`$DCONF read $BASE_KEY_NEW/default | tr -d \'`
            else
                DEFAULT_SLUG=`$DCONF list $BASE_KEY_NEW/ | grep '^:' | head -n1 | tr -d :/`
            fi

            DEFAULT_KEY="$BASE_KEY_NEW/:$DEFAULT_SLUG"
            PROFILE_KEY="$BASE_KEY_NEW/:$PROFILE_SLUG"

            # copy existing settings from default profile

            $DCONF dump "$DEFAULT_KEY/" | $DCONF load "$PROFILE_KEY/"

            dconf_create_profile "$pa" "$bg" "$fg" "$bo" "$pn" "$ps" "$BASE_KEY_NEW"

            unset PROFILE_NAME
            unset PROFILE_SLUG
            unset DCONF
            unset UUIDGEN
            exit 0
        fi
    fi

    # Fallback for Gnome 2 and early Gnome 3
    [[ -z "$GCONFTOOL" ]] && GCONFTOOL=gconftool
    [[ -z "$BASE_KEY" ]] && BASE_KEY=/apps/gnome-terminal/profiles

    PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

    KEY="/apps/gnome-terminal/global/profile_list"

    gconf_create_profile "$pa" "$bg" "$fg" "$bo" "$pn" "$ps" "$KEY"

    unset PROFILE_NAME
    unset PROFILE_SLUG
    unset DCONF
    unset UUIDGEN

} #}}}


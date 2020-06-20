#!/usr/bin/env bash
#
# One line prompt showing the following configurable information
# for git:
# time (virtual_env) username@hostname pwd git_char|git_branch git_dirty_status|→
#
# The → arrow shows the exit status of the last command:
# - bold green: 0 exit status
# - bold red: non-zero exit status
#
# Example outside git repo:
# 07:45:05 user@host ~ →
#
# Example inside clean git repo:
# 07:45:05 user@host .oh-my-bash ±|master|→
#
# Example inside dirty git repo:
# 07:45:05 user@host .oh-my-bash ±|master ✗|→
#
# Example with virtual environment:
# 07:45:05 (venv) user@host ~ →
#

icon_user=""
icon_host="@"
icon_directory=" in 📁 "

SCM_NONE_CHAR=''
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX=" on 🌿 ${green}<"
SCM_THEME_PROMPT_SUFFIX="${green}>"
SCM_GIT_SHOW_MINIMAL_INFO=true

CLOCK_THEME_PROMPT_PREFIX=''
CLOCK_THEME_PROMPT_SUFFIX=' '
THEME_SHOW_CLOCK=true
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$bold_blue"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%I:%M:%S"}

VIRTUALENV_THEME_PROMPT_PREFIX='🐍 ('
VIRTUALENV_THEME_PROMPT_SUFFIX=') '

function prompt_command() {
    # This needs to be first to save last command return code
    local RC="$?"

    hostname="${icon_user}${bold_yellow}\u${normal}${icon_host}${bold_cyan}\h${normal}"
    virtualenv="${pink}$(virtualenv_prompt)"

    # Set return status color
    if [[ ${RC} == 0 ]]; then
        ret_status="${bold_orange}"
    else
        ret_status="${bold_red}"
    fi

    # Append new history lines to history file
    history -a

    #PS1="${virtualenv}${hostname} ${bold_cyan}\W $(scm_prompt_char_info)${ret_status}→ ${normal}"
    PS1="${virtualenv}${hostname}${icon_directory}${bold_purple}\W${normal} $(scm_prompt_char_info)
  ${ret_status}⤳ ${normal}"
    PS2="> "
    PS4="+ "   

}

safe_append_prompt_command prompt_command

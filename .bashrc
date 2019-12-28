#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
. ~/.bash_aliases

# set default apps
export EDITOR=nvim
export TERMINAL=alacritty

# prompt
PS1="[\[\e[32m\]\W\[\e[m\]]"

# resize screen
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# vim bindings
set -o vi

# enable auto cd
shopt -s autocd

# add colors to less (the default pager)
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

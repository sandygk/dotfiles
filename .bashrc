#!/bin/bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# aliases
. ~/.bash_aliases

# source the open script to be able to cd from it
. ~/bin/open

# set default apps
export EDITOR=nvim
export TERMINAL=alacritty

# prompt
PS1="[\[\e[32m\]\W\[\e[m\]]"

# resize screen
shopt -s checkwinsize

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file
shopt -s histappend

# set history size
HISTSIZE=10000
HISTFILESIZE=10000

# autocorrect cd mispellings
shopt -s cdspell

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

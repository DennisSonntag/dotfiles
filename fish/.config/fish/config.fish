if status is-interactive
    # Commands to run in interactive sessions can go here
end

# abbr -a gco git checkout
# function multicd
#     echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
# end
# abbr --add dotdot --regex '^\.\.+$' --function multicd


# -------------------------------Tokyo night theme--------------------------------------
# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 364a82
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

# ------------------------------------------------------------------------------------






set fish_greeting
set fish_vi_key_bindings
set fish_cursor_insert line

abbr -a p doas pacman
abbr -a pa paru

alias nm="doas nmtui"
alias np="ping 1.1.1.1"
alias n="pnpm"
alias v="nvim"
alias ..="cd .."
alias ls="lsd"
alias lsl="lsd -1"
alias la="lsd -A"
alias lal="lsd -1A"
alias ga="git add"
alias gaa="git add ."
alias gc="git commit -m"
alias gpush="git push origin master"
alias gpushm="git push origin master"
alias gpull="git pull"
alias c="clear"
alias ccd="cd;clear"
alias rm="trash"
alias bd="doas brillo -u 150000 -q -U 10"
alias bu="doas brillo -u 150000 -q -A 10"
alias mirror="doas reflector -p https -l 50 --sort rate --verbose --save /etc/pacman.d/mirrorlist"
alias prc="wget -O .prettierrc.json https://pastebin.com/raw/qhk1hkEB"

function gfpull 
	git fetch --all
	git reset --hard origin/master
end

function take 
	mkdir -p $argv
	cd $argv
end

function clear-cache 
	doas pacman -Scc --noconfirm
	paru -Scc --noconfirm
	cargo cache -a
	trash-emtpy
	doas pacman -Rcns (pacman -Qdtq)
end

function full-update
	mirror
	doas pacman -Syyu --noconfirm
	paru -Syyu --noconfirm
	rustup update stable
	rustup update nightly
	cargo install-update -a
	bob sync
	bob install nightly
	bob use nightly
	nvm install latest
	nvm install lts
	nvm use lts
	clear-cache
end

set PATH $HOME/.cargo/bin $PATH

fish_add_path -m ~/.local/bin
fish_add_path -m ~/.local/share/bob/nvim-bin

if [ "$(tty)" = "/dev/tty1" ]
	exec Hyprland
end



# Functions needed for !! and !$
function __history_previous_command
	switch (commandline -t)
	case "!"
		commandline -t $history[1]; commandline -f repaint
	case "*"
		commandline -i !
	end
end

function __history_previous_command_arguments
	switch (commandline -t)
	case "!"
		commandline -t ""
		commandline -f history-token-search-backward
	case "*"
		commandline -i '$'
	end
end

function beans
	tmux-sessionizer
end


# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


bind -M insert \cf tmux-sessionizer

starship init fish | source
zoxide init fish | source
fish_ssh_agent
# nvm use latest > /dev/null
nvm use lts > /dev/null



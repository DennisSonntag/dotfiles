if status is-interactive
    # Commands to run in interactive sessions can go here
end

# abbr -a gco git checkout
# function multicd
#     echo cd (string repeat -n (math (string length -- $argv[1]) - 1) ../)
# end
# abbr --add dotdot --regex '^\.\.+$' --function multicd




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
alias ga="git add ."
alias gc="git commit -m"
alias gpush="git push origin master"
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
end

function full-update
	clear-cache
	mirror
	doas pacman -Syyu --noconfirm
	paru -Syyu --noconfirm
	doas pacman -Rcns (pacman -Qdtq)
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



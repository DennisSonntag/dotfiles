{ config, pkgs,  ... }:


let 
  lib = pkgs.lib;
in

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    neofetch
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    yq-go # yaml processor https://github.com/mikefarah/yq
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    tldr

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dennis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.git = {
    enable = true;
    userName = "Dennis Sonntag";
    userEmail = "dennis.sonntag@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.starship = {
    enable = true;
    package = pkgs.starship;
    # custom settings
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
	"$username"
	"$hostname"
	"$directory"
	"$git_branch"
	"$git_state"
	"$git_status"
	"$cmd_duration"
	"$python"
	"$character"
      ];

      
    directory = {
      style = "blue";
    };
    
    character = {
      success_symbol = "[❯](purple)";
      error_symbol = "[❯](red)";
      vimcmd_symbol = "[❮](green)";
    };
    
    git_branch = {
      format = "[$branch]($style)";
      style = "bright-black";
    };
    
    git_status = {
      format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
      style = "cyan";
      conflicted = "​";
      untracked = "​";
      modified = "​";
      staged = "​";
      renamed = "​";
      deleted = "​";
      stashed = "≡";
    };
    
    git_state = {
      format = "\([$state( $progress_current/$progress_total)]($style)\) ";
      style = "bright-black";
    };
    
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "yellow";
    };
    
#     python = {
#       format = "[$virtualenv]($style) ";
#       style = "bright-black";
#     };


    };
  };


  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    # custom settings
    theme = "Tokyo Night Storm";
    extraConfig = "modify_font underline_thickness 200%\nmodify_font underline_position 1";
    font = {
    	size = 14;
    	name = "JetBrainsMono NF Regular";
	package = pkgs.nerdfonts;
    };
    settings = {
	bold_font = "auto";
	italic_font = "auto";
	bold_italic_font = "auto";
	confirm_os_window_close = 0;
	disable_ligatures = "never";
	background_opacity = "0.8";
	dynamic_background_opacity = "yes";
	undercurl_style = "thick-dense";
    };
  };
}

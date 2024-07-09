{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      # Download disko
      "${builtins.fetchTarball {
        url = "https://github.com/nix-community/disko/archive/master.tar.gz";
	sha256 = "0sn6bd7nyfa2p168pway1a7yzq6bvagpww8q3j69bb6fw1xgm6yc";
	}}/module.nix"

      ./disk-config.nix
    ];

  stylix.enable = true;

  stylix.base16Scheme =  "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
  stylix.polarity = "dark";
  stylix.image = ./wallappers/kimiNoWa.png;

  stylix.fonts = {
    serif = {
      package = pkgs.roboto-serif;
      name = "Roboto Serif";
    };

    sansSerif = {
      package = pkgs.roboto;
      name = "Roboto Sans";
    };

    monospace = {
	  package = pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; };
      name = "JetBrainsMono Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  stylix.cursor.package = pkgs.phinger-cursors;
  stylix.cursor.name =" phinger-cursors-light";


  # users.${user}.dennis.gtk = {
  #   iconTheme = {
  #  package = pkgs.kora-icon-theme;
  #  name = "kora";
  #   };
  # };


  stylix.fonts.sizes = {
    applications = 12;
    terminal = 14;
    desktop = 15;
    popups = 10;
  };


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "archie"; # Define your hostname.
  # Pick only one of the below networking options.
  # TODO: modularize this for laptop
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];


  # TODO: modularize this because this is specific to desktop config
  boot.kernelParams = [
	  "video=DP-1:1920x1080@75"
	  "video=HDMI-A-1:1920x1080@75"
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;


  environment.sessionVariables = {
  	NIXOS_OZONE_WL = "1";

	# hyprland env vars
	EDITOR = "nvim";
	SUDO_EDITOR = "/home/dennis/.local/share/bob/nvim-bin/nvim";

	WLR_NO_HARDWARE_CURSORS = "1";
	XDG_RUNTIME_DIR = "/run/user/1000/";

	WLR_DRM_DEVICES = "/dev/dri/card1";

	XDG_CURRENT_DESKTOP = "Hyprland";
	XDG_SESSION_TYPE = "wayland";
	XDG_SESSION_DESKTOP = "Hyprland";


	QT_AUTO_SCREEN_SCALE_FACTOR = "1";
	QT_QPA_PLATFORM = "wayland;xcb";
	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
	QT_QPA_PLATFORMTHEME = "qt5ct";
	CLUTTER_BACKEND = "wayland";
	GBM_BACKEND = "nvidia-drm";
	WLR_DRM_NO_ATOMIC = "1";

	__GLX_VENDOR_LIBRARY_NAME = "nvidia";
	LIBVA_DRIVER_NAME = "nvidia";
	SDL_VIDEODRIVER = "wayland";
	_JAVA_AWT_WM_NONEREPARENTING = "1";
	GDK_BACKEND = "wayland,x11";
	GTK_THEME = "Nordic";
	# XCURSOR_THEME = "Fluent-dark-cursors";
	# XCURSOR_SIZE = "24";
  };

  programs.fish = {
    enable = true;
    package = pkgs.fish;
    interactiveShellInit = "starship init fish | source";
    shellInit = "
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

	set fish_greeting
	set fish_key_bindings fish_vi_key_bindings
	set fish_cursor_insert line";

  shellAliases = {
    clip-c="wl-copy -c";
    rle="systemctl restart --user emacs";
    trash-size="dust ~/.local/share/Trash/";
    wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
    kill-lua="kill (pgrep lua-language-se)";
    kill-rust="kill (pgrep rust-analyzer)";
    nm="doas nmtui";
    np="ping 1.1.1.1";
    n="pnpm";
    v="nvim";
    lv="NVIM_APPNAME=LazyVim nvim";
    ov="NVIM_APPNAME=nvimOld nvim";
    t="tmux attach || tmux new";
    ".."="cd ..";
    ls="lsd";
    lsl="lsd -1";
    la="lsd -A";
    lal="lsd -1A";
    clippy_better="cargo clippy --no-deps --all-targets --color always -- -W clippy::pedantic -W clippy::nursery";
    
    # Git;
    gcl="git clone --recursive";
    ga="git add";
    gc="git commit";
    gl="git log --graph --oneline --decorate";
    gd="git diff";
    gpush="git push origin main";
    gpushm="git push origin master";
    gpull="git pull";

    
    update-stats="checkupdates | rg \"linux-zen \"";
    
    ssh-ubuntu-server="ssh -i ~/.ssh/id_ed25519_homelab dennis@192.168.1.219";
    c="clear";
    ccd="cd;clear";
    rm="trash";
    bu="doas brillo -u 150000 -q -A 10";
    bd="doas brillo -u 150000 -q -U 10";
    mirror="doas reflector -p https -l 50 --sort rate --verbose --save /etc/pacman.d/mirrorlist";
    prc="wget -O .prettierrc.json https://pastebin.com/raw/qhk1hkEB";

    nvim-lazy="NVIM_APPNAME=LazyVim nvim";
    nvim-chad="NVIM_APPNAME=NvChad nvim";
    nvim-astro="NVIM_APPNAME=AstroNvim nvim";
  };

  };

  users.defaultUserShell = pkgs.fish;
  

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    #alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # Enable touchpad support (enabled default in most desktopManager).
  # TODO: modularize this for laptop
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dennis = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  environment.variables.EDITOR = "nvim";


  environment.systemPackages = with pkgs; [
    vim
    wl-clipboard
    bun
    lsd
    bat
    ripgrep
    fd
    git
    wget
    curl
    starship
    pavucontrol
    neovim
    firefox
    grimblast
    gcc
    kitty
    clang
    trash-cli
    roboto

	hyprpicker
	slurp
	wf-recorder
	wl-clipboard
	wayshot
	swappy
	supergfxctl

    #ags stuff
    dart-sass
    fd
    brightnessctl
    swww
    matugen
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}


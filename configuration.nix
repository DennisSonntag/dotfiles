{
  config,
  lib,
  pkgs,
  flake,
  inputs,
  ...
}: let
  myNixCats = import ./nvim/default.nix {inherit inputs;};
  brightness-py = pkgs.writers.writePython3Bin "brightness-py" {
    flakeIgnore = ["E508" "W293" "E303" "E501" "E265" "F401" "W291" "W391" "F811"];
  } (builtins.readFile ./nonnix/waybar/brightness.py);
  emoteWithPatch = pkgs.emote.overrideAttrs (oldAttrs: {
    patches =
      (oldAttrs.patches or [])
      ++ [
        ./emote-patch.patch
      ];
  });
in {
  imports = [
    ./hardware-configuration.nix
    # Download disko
    "${builtins.fetchTarball {
      url = "https://github.com/nix-community/disko/archive/master.tar.gz";
      # sha256 = "0b8fxndp7b0yqpyzlbfyg7b7m59b0yqpfl37q1lf0awzs6dsknzi";
      # sha256 = "0jsa4ymxr2l9ymzx4c1z9y96qvh45sh1vdps73yb2ang5ajvqlrc";
      # sha256 = "1jayvmcnq4g6k0pzzz3nq9f46q7nj2knsq2jrxikhc5xms42xhdc";
      # sha256 = "0hizsz2f23g0hw4gqivmr0z6h5zr3371jasl16acajc5fsl397nx";
      # sha256 = "0rlzjdw5l0gcjmh34san0qb25a3xxfcwdh75ppr343nzfrj8zbsq";
      sha256 = "1dcakwcvbqapvd6c321kdrhki30dn1pbnffvzhdb0ab4gman9fcq";
    }}/module.nix"

    ./disk-config.nix
  ];

  nix.nixPath = [
    "nixos-config=${config.users.users.dennis.home}/nixos/configuration.nix"
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  stylix.enable = true;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
  stylix.polarity = "dark";
  stylix.image = ./wallappers/kimiNoWa.png;

  nixpkgs.config.allowUnfree = true;

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
      # package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      # package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  fonts = {
    packages = with pkgs; [
      # (nerdfonts.override {fonts = ["JetBrainsMono"];})
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];

    fontconfig.defaultFonts.monospace = ["JetBrainsMono Nerd Font"];
  };

  # stylix.cursor.package = pkgs.rose-pine-cursor;
  # stylix.cursor.name = "rose-pine-cursor";

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
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  boot.initrd.kernelModules = ["amdgpu" "i2c-dev"];
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable nvidia driver support
  # services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics.enable = true; # Before 24.11: hardware.opengl.driSupport
  # For 32 bit applications
  hardware.graphics.enable32Bit = true; # Before 24.11: hardware.opengl.driSupport32Bit
  hardware.graphics.extraPackages = with pkgs; [
    # rocmPackages.clr
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
    amdvlk
  ];

  hardware.opentabletdriver.enable = true;

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  # TODO: modularize this because this is specific to desktop config
  boot.kernelParams = [
    "video=DP-1:1920x1080@75"
    "video=HDMI-A-1:1920x1080@75"
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ];

  # services.displayManager.sddm.wayland.enable = true;

  environment.sessionVariables = {
    PATH = [
      "\${HOME}/.npm-packages/bin"
    ];
    PNPM_HOME = "\${HOME}/.npm-packages/bin";

    NODE_PATH = "~/.npm-packages/lib/node_modules";

    # STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/user/.steam/root/compatibilitytools.d";

    NIXOS_OZONE_WL = "1";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json:/run/opengl-driver-32/share/vulkan/icd.d/radeon_icd.i686.json";

    # hyprland env vars
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";

    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_RUNTIME_DIR = "/run/user/1000/";

    WLR_DRM_DEVICES = "/dev/dri/card1";

    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    CLUTTER_BACKEND = "wayland";
    GBM_BACKEND = "nvidia-drm";
    WLR_DRM_NO_ATOMIC = "1";

    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    GDK_BACKEND = "wayland,x11";
    GTK_THEME = "Nordic";

    # XCURSOR_THEME = "rose-pine-hyprcursor";
    # XCURSOR_SIZE = "24";
    # HYPRCURSOR_THEME = "rose-pine-hyprcursor";
    # HYPRCURSOR_SIZE = "24";
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
	set fish_cursor_insert line
	zoxide init fish | source";

    shellAliases = {
      clip-c = "wl-copy -c";
      rle = "systemctl restart --user emacs";
      trash-size = "dust ~/.local/share/Trash/";
      wget = "wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\"";
      kill-lua = "kill (pgrep lua-language-se)";
      kill-rust = "kill (pgrep rust-analyzer)";
      nm = "doas nmtui";
      np = "ping 1.1.1.1";
      n = "pnpm";
      t = "tmux attach || tmux new";
      ".." = "cd ..";
      ls = "lsd";
      lsl = "lsd -1";
      la = "lsd -A";
      lal = "lsd -1A";
      clippy_better = "cargo clippy --no-deps --all-targets --color always -- -W clippy::pedantic -W clippy::nursery";

      # Git;
      gcl = "git clone --recursive";
      ga = "git add";
      gc = "git commit";
      gl = "git log --graph --oneline --decorate";
      gd = "git diff";
      gpush = "git push origin main";
      gpushm = "git push origin master";
      gpull = "git pull";

      update-stats = "checkupdates | rg \"linux-zen \"";

      ssh-ubuntu-server = "ssh -i ~/.ssh/id_ed25519_homelab dennis@192.168.1.219";
      c = "clear";
      ccd = "cd;clear";
      rm = "trash";
      bu = "doas brillo -u 150000 -q -A 10";
      bd = "doas brillo -u 150000 -q -U 10";
      mirror = "doas reflector -p https -l 50 --sort rate --verbose --save /etc/pacman.d/mirrorlist";
      prc = "wget -O .prettierrc.json https://pastebin.com/raw/qhk1hkEB";
    };
  };

  users.defaultUserShell = pkgs.fish;

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.pulseaudio.enable = false;

  # ALSA provides a udev rule for restoring volume settings.
  services.udev.packages = [pkgs.alsa-utils];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    audio.enable = true;
    jack.enable = true;
    pulse.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # TODO: modularize this for laptop
  # services.libinput.enable = true;
  users.users.syncthing.group = "syncthing";
  users.groups.syncthing = {};

  users.users.syncthing.isSystemUser = true;

  users.groups.i2c = {};
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dennis = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "syncthing" "i2c"];
    home = "/home/dennis";
  };

  users.users.syncthing.extraGroups = ["users"];
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  systemd.tmpfiles.rules = [
    "d /home/dennis 0750 dennis syncthing"
  ];

  # 		security.sudo.extraRules = [
  #   {
  #     users = ["dennis"];
  #     commands = [
  #       {
  #         command = "${brightness-py}/bin/brightness-py";
  #         options = ["NOPASSWD" "SETENV"];
  #       }
  #     ];
  #   }
  # ];

  environment.systemPackages = with pkgs; [
    brightness-py
    (pkgs.writeShellScriptBin "v" "nvim $@")

    (pkgs.writeShellScriptBin "controls.sh" (builtins.readFile ./nonnix/waybar/player-controls.sh))

    (writers.writePython3Bin "spotify-meta" {
      flakeIgnore = ["E508" "W293" "E303" "E501" "E265" "F401" "W291" "W391" "F811"];
    } (builtins.readFile ./nonnix/waybar/spotify-meta.py))

    # (writers.writePython3Bin "waybar-ddcutil" {
    #   flakeIgnore = ["E508" "W293" "E303" "E501" "E265" "F401"  "W291" "W391" "F811"];
    # } (builtins.readFile ./nonnix/waybar/waybar-ddcutil.py))

    # (writers.writePython3Bin "test-name-python" {
    #   } ''
    #     print("hello fucking world")
    #   '')

    playerctl
    ddcutil
    ddcui
    discord-canary

    dunst
    alsa-utils
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
    rofi-wayland

    firefox
    brave
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
    # bottles
    obsidian
    wayshot
    swappy
    supergfxctl
    dart-sass
    fd
    brightnessctl
    swww
    pamixer
    pnpm
    nodejs
    protonup
    # steam
    localsend
    gdu
    imagemagick
    feh
    hyprpaper
    poppler_utils
    zoxide
    galculator
    python3

    audacity

    emoteWithPatch
    ydotool

    # calibre

    myNixCats.packages.${pkgs.system}.nvim
    (pkgs.writeShellScriptBin "v" "nvim $@")

    # (let
    #   python = pkgs.python3;
    #   pythonPackages = python.pkgs;
    #   myPythonEnv = python.withPackages (ps: with ps; [requests]);
    # in
    #   pkgs.writers.writePython3Bin "my-test-python-script" ''
    #     #!${myPythonEnv.interpreter}
    sonusmix
    anki-bin
    obs-studio
    # lutris-unwrapped
    wine-wayland
    dxvk
    vkd3d
    vulkan-loader
    mesa
    winetricks
    mpv
    clang-tools

    driversi686Linux.mesa
    glfw
    libGL
    libGLU
    clang
    lld
    glew
    # blender
    cloc
    sloc
    libcef
    glm

    # tor
    # tor-browser-bundle-bin
    ghostty

    vulkan-tools

    scc
    pureref

    osu-lazer-bin

    exercism
    cmake
    sdl3
    bats
    go
    dust
    gdb

    #     # import requests
    #     import json
    #
    #     # Your script here
    #     print("Hello, Fucking World!")
    #   '')
  ];

  # nix.settings.download-buffer-size = 134217728; # 128 MiB
  nix.settings.download-buffer-size =   524288000; # 

  programs.steam.enable = true;
  # programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  programs.hyprland.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [80 443 1701 9001];
    allowedUDPPortRanges = [
      {
        from = 4000;
        to = 4007;
      }
      {
        from = 8000;
        to = 8010;
      }
    ];
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

  nix.settings.experimental-features = ["nix-command" "flakes"];
}

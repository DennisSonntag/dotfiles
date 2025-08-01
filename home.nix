# just some stuff for get to wake up
{
  inputs,
  config,
  pkgs,
  split-monitor-workspaces,
  utils,
  ...
}: let
  lib = pkgs.lib;
in {
  #imports = [ inputs.ags.homeManagerModules.default ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    options = [
      "--cmd cd"
    ];
  };


  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };


  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  programs.waybar = {
    enable = true;
  };




  home.file = {
    "${config.home.homeDirectory}/.config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/waybar";
    "${config.home.homeDirectory}/.clang-format".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/clang/.clang-format";
    "${config.home.homeDirectory}/.config/emacs".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/emacs";

    "${config.home.homeDirectory}/.config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/tmux";
    # "${config.home.homeDirectory}/.config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/mpv";
    "${config.home.homeDirectory}/.config/rofi".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/rofi";
    "${config.home.homeDirectory}/.config/dunst".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/dunst";
    "${config.home.homeDirectory}/.gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/git/.gitconfig";

    "${config.home.homeDirectory}/.config/hypr/hyprpaper.conf".text = ''
            # Pc stuff
            #preload = ~/Wallappers/DualMonitor/right-half-1.jpg
            #preload = ~/Wallappers/DualMonitor/right-half-0.jpg

            #wallpaper = DP-1,~/Wallappers/DualMonitor/right-half-1.jpg
            #wallpaper = HDMI-A-1,~/Wallappers/DualMonitor/right-half-0.jpg

            preload = ~/Pictures/output_0.jpg
            preload = ~/Pictures/output_1.jpg

            wallpaper = HDMI-A-1,~/Pictures/output_0.jpg
            wallpaper = DP-1, ~/Pictures/output_1.jpg

      # Laptop stuff
      # preload = ~/.wallpapers/macOS_Sonoma_6K.png

      # wallpaper = eDP-1,~/.wallpapers/macOS_Sonoma_6K.png
    '';
    ".prettierrc".text = ''
      {
        "plugins": ["prettier-plugin-tailwindcss","prettier-plugin-svelte"],
        "pluginSearchDirs": ["."],
        "overrides": [{ "files": "*.svelte", "options": { "parser": "svelte" } }],
        "semi": true,
        "singleQuote": false,
        "tabWidth": 4,
        "useTabs": true,
      }
    '';
    ".npmrc".text = ''
      prefix = \$\{HOME}/.npm-packages
    '';
  };


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # prismlauncher
    neofetch
    nemo
    nnn # terminal file manager

    tmux

    spotify

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
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses


    hyprsunset
    cef-binary


    brave



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

    btop # replacement of htop/nmon
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
        "$nix_shell"
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


    };
  };

  programs.kitty = {
    enable = true;
    package = pkgs.kitty;
    extraConfig = "modify_font underline_thickness 200%\nmodify_font underline_position 1";
    font = {
      size = 14;
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    plugins = [
      split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      # split-monitor-workspaces.packages.${pkgs.system}.hyprsplit
    ];
    
    settings = {
      plugin = {
       "split-monitor-workspaces" = {
       # "hyprsplit" = {
         count = 9;
       };
      };
      exec-once = [
        "wl-clipboard-history -t"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        # "hyprctl setcursor rose-pine-hyprcursor 24"
        "lxsession"
        "waybar"
        "hyprpaper"
        # "ags"
        "otd-daemon"
      ];

      monitor = [
        # "HDMI-A-1 ,1920x1080@75,0x0,1, transform, 1"
        "HDMI-A-1 ,1920x1080@75,0x0,1"
        "DP-1 ,1920x1080@75,1920x0,1"
        # "DP-1 ,1920x1080@75,1080x0,1"
      ];
      workspace = [
        "1, monitor:DP-1, default:true"
        "2, monitor:DP-1"
        "3, monitor:DP-1"
        "4, monitor:DP-1"
        "5, monitor:DP-1"
        "6, monitor:DP-1"
        "7, monitor:DP-1"
        "8, monitor:DP-1"
        "9, monitor:DP-1"

        "11, monitor:HDMI-A-1, default:true"
        "12, monitor:HDMI-A-1"
        "13, monitor:HDMI-A-1"
        "14, monitor:HDMI-A-1"
        "15, monitor:HDMI-A-1"
        "16, monitor:HDMI-A-1"
        "17, monitor:HDMI-A-1"
        "18, monitor:HDMI-A-1"
        "19, monitor:HDMI-A-1"

        "special:misc, on-created-empty:[tile] kitty"
        "special:discord, on-created-empty:[tile] vencord-desktop"
        "special:music, on-created-empty:[tile] spotify"
      ];

      bind = [
        # "SUPER, 1, execr, hyprctl dispatch split-workspace 1"
        # "SUPER, 2, execr, hyprctl dispatch split-workspace 2"
        # "SUPER, 3, execr, hyprctl dispatch split-workspace 3"
        # "SUPER, 4, execr, hyprctl dispatch split-workspace 4"
        # "SUPER, 5, execr, hyprctl dispatch split-workspace 5"
        # "SUPER, 6, execr, hyprctl dispatch split-workspace 6"
        # "SUPER, 7, execr, hyprctl dispatch split-workspace 7"
        # "SUPER, 8, execr, hyprctl dispatch split-workspace 8"
        # "SUPER, 9, execr, hyprctl dispatch split-workspace 9"
        #
        # "SUPER SHIFT, 1, execr, hyprctl dispatch split-movetoworkspacesilent 1"
        # "SUPER SHIFT, 2, execr, hyprctl dispatch split-movetoworkspacesilent 2"
        # "SUPER SHIFT, 3, execr, hyprctl dispatch split-movetoworkspacesilent 3"
        # "SUPER SHIFT, 4, execr, hyprctl dispatch split-movetoworkspacesilent 4"
        # "SUPER SHIFT, 5, execr, hyprctl dispatch split-movetoworkspacesilent 5"
        # "SUPER SHIFT, 6, execr, hyprctl dispatch split-movetoworkspacesilent 6"
        # "SUPER SHIFT, 7, execr, hyprctl dispatch split-movetoworkspacesilent 7"
        # "SUPER SHIFT, 8, execr, hyprctl dispatch split-movetoworkspacesilent 8"
        # "SUPER SHIFT, 9, execr, hyprctl dispatch split-movetoworkspacesilent 9"

        "SUPER, 1, split-workspace, 1"
        "SUPER, 2, split-workspace, 2"
        "SUPER, 3, split-workspace, 3"
        "SUPER, 4, split-workspace, 4"
        "SUPER, 5, split-workspace, 5"
        "SUPER, 6, split-workspace, 6"
        "SUPER, 7, split-workspace, 7"
        "SUPER, 8, split-workspace, 8"
        "SUPER, 9, split-workspace, 9"

        "SUPER SHIFT, 1, split-movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, split-movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, split-movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, split-movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, split-movetoworkspacesilent, 5"
        "SUPER SHIFT, 6, split-movetoworkspacesilent, 6"
        "SUPER SHIFT, 7, split-movetoworkspacesilent, 7"
        "SUPER SHIFT, 8, split-movetoworkspacesilent, 8"
        "SUPER SHIFT, 9, split-movetoworkspacesilent, 9"

        # "SUPER, 1, split:workspace, 1"
        # "SUPER, 2, split:workspace, 2"
        # "SUPER, 3, split:workspace, 3"
        # "SUPER, 4, split:workspace, 4"
        # "SUPER, 5, split:workspace, 5"
        # "SUPER, 6, split:workspace, 6"
        # "SUPER, 7, split:workspace, 7"
        # "SUPER, 8, split:workspace, 8"
        # "SUPER, 9, split:workspace, 9"
        #
        # "SUPER SHIFT, 1, split:movetoworkspacesilent, 1"
        # "SUPER SHIFT, 2, split:movetoworkspacesilent, 2"
        # "SUPER SHIFT, 3, split:movetoworkspacesilent, 3"
        # "SUPER SHIFT, 4, split:movetoworkspacesilent, 4"
        # "SUPER SHIFT, 5, split:movetoworkspacesilent, 5"
        # "SUPER SHIFT, 6, split:movetoworkspacesilent, 6"
        # "SUPER SHIFT, 7, split:movetoworkspacesilent, 7"
        # "SUPER SHIFT, 8, split:movetoworkspacesilent, 8"
        # "SUPER SHIFT, 9, split:movetoworkspacesilent, 9"

        "SUPERSHIFT, 0, movetoworkspace, special:misc"
        "SUPER, 0, togglespecialworkspace, misc"

        "SUPERSHIFT, d, movetoworkspace, special:discord"
        "SUPER, d, togglespecialworkspace, discord"

        "SUPERSHIFT, m, movetoworkspace, special:music "
        "SUPER, m, togglespecialworkspace, music "

        "SUPER, o, exec, obsidian"

        "SUPER, B, exec, firefox"
        "SUPER, X, exec, ${config.home.homeDirectory}/.config/rofi/powermenu/type-2/powermenu.sh"

        "SUPER SHIFT, S, exec, grimblast --freeze copy area"
        "SUPER SHIFT, P, exec, hyprpicker -f hex -a -r"

        ", Print, exec, grimblast --notify --cursor copysave output"
        "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        "CTRL ALT, L, exec, swaylock"
        "SUPER, Return, exec, kitty"
        # "SUPER, Return, exec, ghostty"
        "SUPER, F, exec, nemo"

        "SUPER, P, exec, ${config.home.homeDirectory}/.config/rofi/launchers/type-2/launcher.sh"

        "SUPER, C, killactive,"
        "SUPER SHIFT, Q, exit,"
        "SUPER SHIFT, F, fullscreen,"
        "SUPER, Space, togglefloating,"

        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"

        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, l, movewindow, r"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, j, movewindow, d"

        "SUPER CTRL, h, resizeactive, -20 0"
        "SUPER CTRL, l, resizeactive, 20 0"
        "SUPER CTRL, k, resizeactive, 0 -20"
        "SUPER CTRL, j, resizeactive, 0 20"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
      ];
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      binde = ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";

      bindl = ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

      bindle = [
        ", XF86MonBrightnessUp, exec, doas brillo -u 150000 -q -A 10"
        ", XF86MonBrightnessDown, exec, doas brillo -u 150000 -q -U 10"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        repeat_rate = 60;
        repeat_delay = 250;
        force_no_accel = true;
      };

      general = {
        gaps_in = 3;
        gaps_out = 6;
        border_size = 0;
        no_border_on_floating = true;
        layout = "master";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        enable_swallow = false;
        # swallow_regex = "^(kitty)$";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.8;

        blur = {
          enabled = true;
          size = 10;
          passes = 3;
          special = true;
        };

        blurls = [
          "gtk-layer-shell"
          "lockscreen"
        ];
      };

      animations = {
        enabled = true;
        animation = [
          "workspaces,1,5,default,slidevert"
          "windows,1,3,default,slide"
          "specialWorkspace,1,4,default,fade"
        ];
      };

      windowrule = [
        "float, title:^(snake|Boids|raycast|floatterm|tetris|pong|maze gen|chess|Browser)$"
        "center, title:^(snake|Boids|raycast|floatterm|tetris|pong|maze gen|chess|Browser)$"
        "monitor HDMI-A-1, title:^(Browser)$"
        "tile, title:^(.*Minecraft.*)$"
      ];
    };
  };
}

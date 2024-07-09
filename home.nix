{ inputs, config, pkgs, split-monitor-workspaces, utils, ... }:

let
  lib = pkgs.lib;
in

{


  #imports = [ inputs.ags.homeManagerModules.default ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dennis";
  home.homeDirectory = "/home/dennis";

  gtk.enable = true;	
  qt.enable = true;	

  gtk.theme = {
    package = pkgs.adw-gtk3;
    name = "adw-gtk3";
  }; 
  gtk.iconTheme = {
   package = pkgs.kora-icon-theme;
   name = "kora";
  }; 


  programs.ags = {
    enable = true;

    # null or path, leave as null if you don't want hm to manage the config
    #configDir = ./ags;

    # additional packages to add to gjs's runtime
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  home.file."${config.home.homeDirectory}/.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nonnix/nvim";
  home.file."${config.home.homeDirectory}/.config/tmux".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nonnix/tmux";
  home.file."${config.home.homeDirectory}/.config/mpv".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nonnix/mpv";


  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    prismlauncher
    neofetch
    cinnamon.nemo
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


  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    plugins = [
      split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

   settings = {
   exec-once = [
      "wl-clipboard-history -t"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      # "hyprctl setcursor Fluent-dark-cursors 24"
      "lxsession"
      "hyprpaper"
      "ags"
      "otd-daemon"
   ];

   monitor = [
       "HDMI-A-1 ,1920x1080@75,1920x0,1"
       "DP-1 ,1920x1080@75,0x0,1"

       #"HDMI-A-1,1920x1080@74.99,1920x0,1.0"
       #"DP-1,1920x1080@75.0,0x0,1.0"
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

       	"10, monitor:HDMI-A-1, default:true"
       	"11, monitor:HDMI-A-1"
       	"12, monitor:HDMI-A-1"
       	"13, monitor:HDMI-A-1"
       	"14, monitor:HDMI-A-1"
       	"15, monitor:HDMI-A-1"
       	"16, monitor:HDMI-A-1"
       	"17, monitor:HDMI-A-1"
       	"18, monitor:HDMI-A-1"

       	"special:misc, on-created-empty:[tile] kitty"
       	"special:discord, on-created-empty:[tile] vencord-desktop"
       	"special:music, on-created-empty:[tile] spotify"
       ];


       bind = [
       	"SUPER, 1, execr, hyprctl dispatch split-workspace 1"
       	"SUPER, 2, execr, hyprctl dispatch split-workspace 2"
       	"SUPER, 3, execr, hyprctl dispatch split-workspace 3"
       	"SUPER, 4, execr, hyprctl dispatch split-workspace 4"
       	"SUPER, 5, execr, hyprctl dispatch split-workspace 5"
       	"SUPER, 6, execr, hyprctl dispatch split-workspace 6"
       	"SUPER, 7, execr, hyprctl dispatch split-workspace 7"
       	"SUPER, 8, execr, hyprctl dispatch split-workspace 8"
       	"SUPER, 9, execr, hyprctl dispatch split-workspace 9"

       	"SUPER SHIFT, 1, execr, hyprctl dispatch split-movetoworkspacesilent 1"
       	"SUPER SHIFT, 2, execr, hyprctl dispatch split-movetoworkspacesilent 2"
       	"SUPER SHIFT, 3, execr, hyprctl dispatch split-movetoworkspacesilent 3"
       	"SUPER SHIFT, 4, execr, hyprctl dispatch split-movetoworkspacesilent 4"
       	"SUPER SHIFT, 5, execr, hyprctl dispatch split-movetoworkspacesilent 5"
       	"SUPER SHIFT, 6, execr, hyprctl dispatch split-movetoworkspacesilent 6"
       	"SUPER SHIFT, 7, execr, hyprctl dispatch split-movetoworkspacesilent 7"
       	"SUPER SHIFT, 8, execr, hyprctl dispatch split-movetoworkspacesilent 8"
       	"SUPER SHIFT, 9, execr, hyprctl dispatch split-movetoworkspacesilent 9"

       	"SUPERSHIFT, 0, movetoworkspace, special:misc"
       	"SUPER, 0, togglespecialworkspace, misc"

       	"SUPERSHIFT, d, movetoworkspace, special:discord"
       	"SUPER, d, togglespecialworkspace, discord"

       	"SUPERSHIFT, m, movetoworkspace, special:music "
       	"SUPER, m, togglespecialworkspace, music "

       	"SUPER, o, exec, obsidian"

       	"SUPER, B, exec, firefox"
       	"SUPER, X, exec, ags -t powermenu"

       	"SUPER SHIFT, S, exec, grimblast --freeze copy area"
       	"SUPER SHIFT, P, exec, hyprpicker -f hex -a -r"

       	", Print, exec, grimblast --notify --cursor copysave output"
       	"ALT, Print, exec, grimblast --notify --cursor copysave screen"
       	"CTRL ALT, L, exec, swaylock"
       	"SUPER, Return, exec, kitty"
       	"SUPER, F, exec, nemo"

       	"SUPER, P, exec, ags -t launcher"

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
       	gaps_in=3;
       	gaps_out=6;
       	border_size=0;
       	no_border_on_floating = true;
       	layout = "master";
       };

       misc = {
       	disable_hyprland_logo = true;
       	disable_splash_rendering = true;
       	mouse_move_enables_dpms = true;
       	enable_swallow = true;
       	swallow_regex = "^(kitty)$";
       };

       decoration = {
       	rounding = 10;

       	active_opacity = 1.0;
       	inactive_opacity = 1.0;

       	blur = {
       		enabled = true;
       		size = 10;
       		passes = 3;
       		special = true;
       	};

       	drop_shadow = true;
       	shadow_ignore_window = true;
       	shadow_offset = "2 2";
       	shadow_range = 4;
       	shadow_render_power = 2;
       	"col.shadow" = "0x66000000";

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
       	"tile, Vivaldi"
       	"tile, firefox"
       	"float, file_progress"
       	"float, confirm"
       	"float, dialog"
       	"float, download"
       	"float, notification"
       	"float, error"
       	"float, splash"
       	"float, confirmreset"
       	"float, title:Open File"
       	"float, title:branchdialog"
       	"float, Lxappearance"
       	"float, Rofi"
       	"noanim, Rofi"
       	"animation none,Rofi"
       	"float,viewnior"
       	"float,feh"
       	"float, pavucontrol"
       	"center, pavucontrol"
       	"float, title:^(Volume Control)$"
       	"size 800 600, title:^(Volume Control)$"
       	"move 75 44%, title:^(Volume Control)$"
       	"float, file-roller"
       	"fullscreen, wlogout"
       	"float, title:wlogout"
       	"fullscreen, title:wlogout"
       	"idleinhibit focus, mpv"
       	"idleinhibit fullscreen, firefox"
       	"float, title:^(Media viewer)$"
       	"float, title:^(Picture-in-Picture)$"
       ];
   };

  };

  programs.firefox = {
    enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
	  extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
            ublock-origin
            bitwarden
            darkreader
            sidebery
            sponsorblock
	    return-youtube-dislikes
          ];
	  settings = {
		  "browser.newtabpage.pinned" = [{
		    title = "NixOS";
		    url = "https://nixos.org";
		  }];
		  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
		    "browser.startup.homepage" = "https://nixos.org";
	  };
	  #userChrome = ''
	  #      See the above repository for updates as well as full license text. */

	  #      /* Hides tabs toolbar */
	  #      /* For OSX use hide_tabs_toolbar_osx.css instead */

	  #      /* Note, if you have either native titlebar or menubar enabled, then you don't really need this style.
	  #       * In those cases you can just use: #TabsToolbar{ visibility: collapse !important }
	  #       */

	  #      /* IMPORTANT */
	  #      /*
	  #      Get window_control_placeholder_support.css
	  #      Window controls will be all wrong without it
	  #      */

	  #      :root[tabsintitlebar]{ --uc-toolbar-height: 40px; }
	  #      :root[tabsintitlebar][uidensity="compact"]{ --uc-toolbar-height: 32px }
	  #      #titlebar{
	  #        will-change: unset !important;
	  #        transition: none !important;
	  #        opacity: 1 !important;
	  #      }
	  #      #TabsToolbar{ visibility: collapse !important }

	  #      :root[sizemode="fullscreen"] #TabsToolbar > :is(#window-controls,.titlebar-buttonbox-container){
	  #        visibility: visible !important;
	  #        z-index: 2;
	  #      }

	  #      :root:not([inFullscreen]) #nav-bar{
	  #        margin-top: calc(0px - var(--uc-toolbar-height,0px));
	  #      }

	  #      :root[tabsintitlebar] #toolbar-menubar[autohide="true"]{
	  #        min-height: unset !important;
	  #        height: var(--uc-toolbar-height,0px) !important;
	  #        position: relative;
	  #      }

	  #      #toolbar-menubar[autohide="false"]{
	  #        margin-bottom: var(--uc-toolbar-height,0px)
	  #      }

	  #      :root[tabsintitlebar] #toolbar-menubar[autohide="true"] #main-menubar{
	  #        flex-grow: 1;
	  #        align-items: stretch;
	  #        background-attachment: scroll, fixed, fixed;
	  #        background-position: 0 0, var(--lwt-background-alignment), right top;
	  #        background-repeat: repeat-x, var(--lwt-background-tiling), no-repeat;
	  #        background-size: auto 100%, var(--lwt-background-size, auto auto), auto auto;
	  #        padding-right: 20px;
	  #      }
	  #      :root[tabsintitlebar] #toolbar-menubar[autohide="true"]:not([inactive]) #main-menubar{
	  #        background-color: var(--lwt-accent-color);
	  #        background-image: linear-gradient(var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor),var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor)), var(--lwt-additional-images,none), var(--lwt-header-image, none);
	  #        mask-image: linear-gradient(to left, transparent, black 20px);
	  #      }

	  #      #toolbar-menubar:not([inactive]){ z-index: 2 }
	  #      #toolbar-menubar[autohide="true"][inactive] > #menubar-items {
	  #        opacity: 0;
	  #        pointer-events: none;
	  #        margin-left: var(--uc-window-drag-space-pre,0px)
	  #      }

	  #      See the above repository for updates as well as full license text. */

	  #      /* Moves tabs toolbar, bookmarks toolbar and main toolbar to the bottom of the window, and makes tabs be the bottom-most toolbar */

	  #      /* By default, menubar will stay on top with two options to select it's behavior - see below */

	  #      @-moz-document url(chrome://browser/content/browser.xhtml){
	  #
	  #        #titlebar{ -moz-appearance: none !important; }

	  #        #navigator-toolbox > div{ display: contents }
	  #        .global-notificationbox,
	  #        #mainPopupSet,
	  #        #browser,
	  #        #customization-container,
	  #        #tab-notification-deck{
	  #          order: -1;
	  #        }

	  #        /* Remove the next row if you want tabs to be the top-most row */
	  #        #titlebar{
	  #          order: 2;
	  #        }

	  #        #toolbar-menubar{
	  #          position: fixed;
	  #          display: flex;
	  #          width: 100vw;
	  #          top: 0px;
	  #          -moz-window-dragging: drag;
	  #        }
	  #        /* Remove bottom border that won't do anything useful when at bottom of the window */
	  #        #navigator-toolbox{ border-bottom: none !important; }

	  #        #toolbar-menubar > spacer{ flex-grow: 1 }

	  #        #urlbar[breakout][breakout-extend]{
	  #          display: flex !important;
	  #          flex-direction: column-reverse;
	  #          bottom: 0px !important; /* Change to 3-5 px if using compact_urlbar_megabar.css depending on toolbar density */
	  #          top: auto !important;
	  #        }

	  #        .urlbarView-body-inner{ border-top-style: none !important; }

	  #        /* Yeah, removes window controls. Likely not wanted on bottom row  */
	  #        #TabsToolbar > .titlebar-buttonbox-container{ display: none }
	  #        #toolbar-menubar > .titlebar-buttonbox-container{ order: 1000 }

	  #        /* Fix panels sizing */
	  #        .panel-viewstack{ max-height: unset !important; }

	  #        /* Fullscreen mode support */
	  #        :root[sizemode="fullscreen"] #navigator-toolbox{ margin-top: 0 !important }
	  #        :root[sizemode="fullscreen"] #navigator-toolbox[style*="margin-top"]{ visibility: collapse }
	  #        #fullscr-toggler{ bottom: 0; top: unset !important; }
	  #
	  #        /* These three rules exist for compatibility with autohide_toolbox.css */
	  #        #navigator-toolbox{ bottom: 0px; transform-origin: bottom }
	  #        #main-window > body > box{ margin-top: 0 !important; }
	  #        #toolbar-menubar{ z-index: 1; background-color: var(--lwt-accent-color,black); }
	  #
	  #        :root[BookmarksToolbarOverlapsBrowser] #navigator-toolbox{
	  #          margin-block: calc(-1 * var(--bookmarks-toolbar-height)) 0 !important;
	  #        }
	  #        :root[BookmarksToolbarOverlapsBrowser] .newTabBrowserPanel{
	  #          padding-block: 0 var(--bookmarks-toolbar-height) !important;
	  #        }
	  #
	  #        /**************
	  #        Menubar options - By default, menubar is overlayed on top of web-content
	  #        ***************/

	  #       /* Uncomment the following if you want static menubar on top of the window (make menubar enabled)
	  #        * Use when menubar is enabled to always show it */
	  #
	  #        /*
	  #        #browser,#customization-container{ padding-top: var(--uc-menubar-spacer,28px) }
	  #        */
	  #
	  #        /* OR, uncomment the following if you want menubar to appear below content, above tabs toolbar */
	  #
	  #        /*
	  #        #toolbar-menubar{ position: static; display: flex; margin-top: 0px !important; background-color: transparent }
	  #        */

	  #        /* set to "column-reverse" (without quotes) if you want tabs above menubar with the above option */
	  #        #titlebar{ flex-direction: column }
	  #      }

	  #      /* Remove close button*/ .titlebar-buttonbox-container{ display:none }
	  #'';
        };
     };
  };


}

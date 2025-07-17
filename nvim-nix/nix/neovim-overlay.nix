# This overlay, when applied to nixpkgs, adds the final neovim derivation to nixpkgs.
{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from a flake input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay.
  pkgs-locked = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation.
  mkNeovim = pkgs.callPackage ./mkNeovim.nix {
      inherit (pkgs-locked) wrapNeovimUnstable neovimUtils;
    };

  # A plugin can either be a package or an attrset, such as
  # { plugin = <plugin>; # the package, e.g. pkgs.vimPlugins.nvim-cmp
  #   config = <config>; # String; a config that will be loaded with the plugin
  #   # Boolean; Whether to automatically load the plugin as a 'start' plugin,
  #   # or as an 'opt' plugin, that can be loaded with `:packadd!`
  #   optional = <true|false>; # Default: false
  #   ...
  # }
  all-plugins = with pkgs.vimPlugins; [
blink-cmp

lsp_signature-nvim
hover-nvim
harpoon
vim-sleuth
lazy-nvim
gitsigns-nvim
telescope-nvim
telescope-fzf-native-nvim
telescope-ui-select-nvim
nvim-web-devicons
plenary-nvim
nvim-lspconfig
lazydev-nvim
fidget-nvim
conform-nvim
nvim-ufo
promise-async
vim-fugitive
neogit
lazygit-nvim
vim-matchup
modicator-nvim
nvim-colorizer-lua
oil-nvim
eyeliner-nvim
lualine-nvim
nvim-ts-context-commentstring
trouble-nvim
nvim-bqf
rainbow-delimiters-nvim
smart-splits-nvim
statuscol-nvim
tokyonight-nvim
todo-comments-nvim
mini-nvim
nvim-treesitter.withAllGrammars

firenvim

nvim-dap
nvim-dap-ui
indent-blankline-nvim
nvim-dap-go
nvim-lint
nvim-autopairs
nui-nvim
nvim-web-devicons
plenary-nvim
nvim-nio
    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
    # which-key-nvim
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
  universal-ctags
  ripgrep
  fd
  stdenv.cc.cc
  nix-doc
  lua-language-server
  glsl_analyzer
  vscode-langservers-extracted
  tailwindcss-language-server
  nodePackages_latest.svelte-language-server
  nodePackages_latest.typescript-language-server
  nixd
  basedpyright
  ccls

  alejandra
  stylua
  prettierd

  delve
  markdownlint-cli

  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This is meant to be used within a devshell.
  # Instead of loading the lua Neovim configuration from
  # the Nix store, it is loaded from $XDG_CONFIG_HOME/nvim-dev
  nvim-dev = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
    appName = "nvim-dev";
    wrapRc = false;
  };

  # This can be symlinked in the devShell's shellHook
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };

  # You can add as many derivations as you like.
  # Use `ignoreConfigRegexes` to filter out config
  # files you would not like to include.
  #
  # For example:
  #
  # nvim-pkg-no-telescope = mkNeovim {
  #   plugins = [];
  #   ignoreConfigRegexes = [
  #     "^plugin/telescope.lua"
  #     "^ftplugin/.*.lua"
  #   ];
  #   inherit extraPackages;
  # };
}

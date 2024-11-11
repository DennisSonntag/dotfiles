{ pkgs, config, lib, ... }:

let
  lazy-nix-helper-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lazy-nix-helper.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "b-src";
      repo = "lazy-nix-helper.nvim";
      rev = "cb1c0c4cf0ab3c1a2227dcf24abd3e430a8a9cd8";
      hash = "sha256-HwrO32Sj1FUWfnOZQYQ4yVgf/TQZPw0Nl+df/j0Jhbc=";
    };
  };

  sanitizePluginName = input:
  let
    name = lib.strings.getName input;
    intermediate = lib.strings.removePrefix "vimplugin-" name;
    result = lib.strings.removePrefix "lua5.1-" intermediate;
  in result;

  pluginList = plugins: lib.strings.concatMapStrings (plugin: "  [\"${sanitizePluginName plugin.name}\"] = \"${plugin.outPath}\",\n") plugins;

in
        #--local plugins = {
        #-- ${pluginList config.programs.neovim.plugins}
        #-- }
  {
    #xdg.configFile."nvim/lua" = {
    #  source = ./nonnix/nvim/lua;
    #  recursive = true;
    #};
	home.file = {

		"${config.home.homeDirectory}/.config/nvim/lua".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos/nonnix/nvim/lua";

};
    programs.neovim = {
      enable = true;
      extraPackages = with pkgs; [
		nodePackages_latest.svelte-language-server
		nodePackages_latest.typescript-language-server
		vscode-langservers-extracted
		tailwindcss-language-server
		prettierd
      ];
      plugins = with pkgs.vimPlugins; [
          lazy-nix-helper-nvim
          lazy-nvim
          # <other plugins>
      ];
      extraLuaConfig = ''
        local lazy_nix_helper_path = "${lazy-nix-helper-nvim}"
        if not vim.loop.fs_stat(lazy_nix_helper_path) then
          lazy_nix_helper_path = vim.fn.stdpath("data") .. "/lazy_nix_helper/lazy_nix_helper.nvim"
          if not vim.loop.fs_stat(lazy_nix_helper_path) then
            vim.fn.system({
              "git",
              "clone",
              "--filter=blob:none",
              "https://github.com/b-src/lazy_nix_helper.nvim.git",
              lazy_nix_helper_path,
            })
          end
        end

        -- add the Lazy Nix Helper plugin to the vim runtime
        vim.opt.rtp:prepend(lazy_nix_helper_path)

        -- call the Lazy Nix Helper setup function
        local non_nix_lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
        local lazy_nix_helper_opts = { lazypath = non_nix_lazypath, input_plugin_table = plugins }
        require("lazy-nix-helper").setup(lazy_nix_helper_opts)

        -- get the lazypath from Lazy Nix Helper
        local lazypath = require("lazy-nix-helper").lazypath()
        if not vim.loop.fs_stat(lazypath) then
          vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
          })
        end
        vim.opt.rtp:prepend(lazypath)

		--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
		vim.g.mapleader = " "
		vim.g.maplocalleader = " "


local icons = require("config.icons")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	defaults = {
		lazy = false, -- TODO: change this to true later
	},
	install = { colorscheme = { "tokyonight" } },
	debug = false,
	performance = {
		cache = {
			enabled = true,
		},
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				"rplugin",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"editorconfig",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	ui = {
		border = "rounded",
		icons = {
			cmd = icons.ui.cmd,
			config = icons.extra.settings,
			event = icons.extra.event,
			ft = icons.folder.closed,
			init = icons.extra.settings,
			keys = icons.extra.keys,
			plugin = icons.extra.plug,
			runtime = icons.extra.runtime,
			require = icons.extra.require,
			source = icons.file.file,
			start = icons.extra.start,
			task = icons.extra.task,
			lazy = icons.extra.lazy,
		},
	},
})
vim.cmd.colorscheme("tokyonight")

require("config")
      '';
    };
  }

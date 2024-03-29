{ self, pkgs, ... }: {

  programs.nixvim = {
    enable = true;
    
    options = {
      # Show line numbers and have relative-line numbers
      number = true;
      relativenumber = true;

      # Set highlight on search
      hlsearch = true;

      # Enable mouse usage
      mouse = "a";

      # Allow clipboard to access system clipboard
      # Setting this to both "unnamed" and "unnamedplus" allows for copy-paste to work
      # even if NixOS is running as a VM Guest.
      clipboard = [ "unnamed" "unnamedplus" ];

      # Enable break indent
      breakindent = true;

      # Enable undo history
      undofile = true;

      # Case-insensitive searching UNLESS \C or capital in search
      ignorecase = true;
      smartcase = true;

      # Decrease update time
      updatetime = 250;
      timeoutlen = 300;

      # Set completeopt to have a better completion experience
      completeopt = [ "menuone" "noinsert" "noselect" ];

    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    plugins = {
      # Nix Support for Vim
      nix.enable = true;

      # Autocompletion
      cmp = {
        enable = true;

        cmdline = {
          ":".sources = [
            { name = "cmdline"; }
            { name = "cmdline-history"; }
          ];
          ":".mapping = {
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };

        settings = {
          snippet.expand = ''
          function(args)
            luasnip.lsp_expand(args.body)
          end
          '';

          completion.completeopt = "menu,menuone,noinsert";
        
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";

            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "calc"; }
            { name = "path"; }
          ];
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;

      cmp-cmdline.enable = true;
      cmp-cmdline-history.enable = true;

      cmp-calc.enable = true;

      # Navigation helper, toggle with :Navbuddy
      # Navic is required by Navbuddy.
      navbuddy.enable = true;
      navic.enable = true;

      # Purposefully makes nvim harder to use by adding timeouts to the basic movement keys
      # This is in order to train to utilize faster and better movement mechanisms
      hardtime.enable = true;

      # Only press tab once!
      intellitab.enable = true;
      
      # Show colors in-place for hex codes
      nvim-colorizer.enable = true;

      # LSP Formatter
      lsp-format.enable = true;

      # Friendly Snippets
      friendly-snippets.enable = true;

      # Multi-cursor support
      multicursors.enable = true;
      
      # Auto-close brackets and quotes
      autoclose.enable = true;

      # Status line
      lualine.enable = true;

      noice = {
        enable = true;
        # Handled by custom box in additional lua
        lsp.signature.enabled = false;
      };

      mini = {
        enable = true;
        modules = {
          surround = { };
        };
      };

      lsp = {
        enable = true;

        onAttach = ''
          local nmap = function(keys, func, desc)
            if desc then
              desc = 'LSP: ' .. desc
            end

            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
          end

          nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          nmap('<leader>ca', function()
            vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
          end, '[C]ode [A]ction')

          nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- See `:help K` for why this keymap
          nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
          nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

          -- Lesser used LSP functionality
          nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
          nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
          nmap('<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, '[W]orkspace [L]ist Folders')

          -- Create a command `:Format` local to the LSP buffer
          vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            vim.lsp.buf.format()
          end, { desc = 'Format current buffer with LSP' })
        '';

        servers = {
          # Lua LSP
          lua-ls.enable = true;

          # Nix LSP
          nixd.enable = true;

          # Rust LSP
          rust-analyzer = {
            enable = true;
            installCargo = true;
            installRustc= true;
            settings.check.command = "clippy";
          };

          # Python LSP
          pyright = {
            enable = true;
          };

          # CSS LSP
          cssls = {
            enable = true;
          };
        };
      };

      # Highlight, edit, and navigate code
      treesitter = {
        enable = true;
        
        # folding = true;
        indent = true;
        nixvimInjections = true;

        ensureInstalled = "all";

        incrementalSelection.enable = true;
      };
      # treesitter-refactor.enable = true;

      # Add indentation guides even on blank lines
      indent-blankline = {
        enable = true;
        indent.highlight = [ 
          "MoonflyGrey58" 
          "MoonflyGrey39" 
          "MoonflyGrey27" 
          "MoonflyGrey23" 
          "MoonflyGrey0" 
          "MoonflyGrey15" 
          "MoonflyCrimson" 
        ];

        # Prevent using scope on certain languages
        # This can prevent them from having one massive scope
        scope.exclude.language = [ 
          "nix" 
          "lspinfo"
          "packer"
          "checkhealth"
          "help"
          "man"
          "gitcommit"
          "TelescopePrompt"
          "TelescopeResults"
        ];
      };
      
      # Enable visual selection commenting with gc / gb
      comment-nvim.enable = true;

      # Fuzzy Finder (files, lsp, etc)
      telescope.enable = true;


      # Show possible next keypress based on currently pressed key
      which-key.enable = true; 
    };

    extraPlugins = [
      # To find the hash, place the following in the field and attempt to build.
      # sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
      # The error message during building will provide the correct hash.
      {
        # Theme
        plugin = (pkgs.vimUtils.buildVimPlugin {
          name = "moonfly";
          src = pkgs.fetchFromGitHub {
            owner = "bluz71";
            repo = "vim-moonfly-colors";
            rev = "3469ee3e54e676deafd9dc29beddfde3643b4d0d";
            hash = "sha256-vC1D/al/jVRyfFbTBpnvogUJsaZsQlcfRQ4j+5MmsbI=";
          };
        });
        config = ''colorscheme moonfly'';
      } 
      {
        # Show LSP Function Signature
        plugin = (pkgs.vimUtils.buildVimPlugin {
          name = "lsp_signature";
          src = pkgs.fetchFromGitHub {
            owner = "ray-x";
            repo = "lsp_signature.nvim";
            rev = "e92b4e7073345b2a30a56b20db3d541a9aa2771e";
            hash = "sha256-WAQ8DWjNWKYBbELC/M8ClGxU0cAqB4X1TlkWIEBqp24=";
          };
        });
      } 
      {
        plugin = (pkgs.vimUtils.buildVimPlugin {
          name = "nvim-lspimport";
          src = pkgs.fetchFromGitHub {
            owner = "stevanmilic";
            repo = "nvim-lspimport";
            rev = "4fef458b8853b1b90b55054ed6c3f98fff094cd1";
            hash = "sha256-JIbd4ygOGuNsg6fZnlN9iz7hfN4LQWM6VSJy4Qh9LJg=";
          };
        });
      } 
      {
        # Auto-generate documentation with <Leader>d
        plugin = (pkgs.vimUtils.buildVimPlugin {
          name = "vim-doge";
          src = pkgs.fetchFromGitHub {
            owner = "kkoomen";
            repo = "vim-doge";
            rev = "e8aa8acb1924ecc78a31c2de487e96ecc92720a9";
            hash = "sha256-SQCCRaLgoHvaVJ98p/LIIIlpGV8qWRrRIEDYQlqIhhg=";
          };
        });
      }
      {
        # Code outline for skimming and quick navigation
        # Use with <leader>a, Skim with n-{ and n-}
        plugin = (pkgs.vimUtils.buildVimPlugin {
          name = "aerial";
          src = pkgs.fetchFromGitHub {
            owner = "stevearc";
            repo = "aerial.nvim";
            rev = "993142d49274092c64a2d475aa726df3c323949d";
            hash = "sha256-BgztBMZCJ1ew4HOiScFzwY8HMhteqmLe/MW4up43/Bo=";
          };
        });
      }
      
      # Detect tabstop and shiftwidth automatically
      pkgs.vimPlugins.vim-sleuth

      pkgs.vimPlugins.luasnip

      pkgs.vimPlugins.nui-nvim

      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.fidget-nvim
    ];

    extraConfigLua = ''
      -- Avoid showing extra messages when using completion
      vim.opt.shortmess:append("c")

      -- Keep signcolumn on by default
      vim.wo.signcolumn = 'yes'

      require('luasnip.loaders.from_vscode').lazy_load()

      -- Custom siguature box
      local signature_cfg = {
        hint_prefix = "🤷 ",
        floating_window_off_x = 5, -- adjust float windows x position.
        floating_window_off_y = function() 
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
          local pumheight = vim.o.pumheight
          local winline = vim.fn.winline() -- line number in the window
          local winheight = vim.fn.winheight(0)

          -- window top
          if winline - 1 < pumheight then
            return pumheight
          end

          -- window bottom
          if winheight - winline < pumheight then
            return -pumheight
          end
          return 0
        end,
      }
      require "lsp_signature".setup(signature_cfg)

      require("aerial").setup({
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
          -- Jump forwards/backwards with '-' and '+'
          vim.keymap.set("n", "-", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "+", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    '';
  };
}

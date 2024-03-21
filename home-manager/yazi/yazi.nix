{ pkgs, lib, home, ... }: 
let
  # To get a SHA-256 for a GitHub repo:
  # Use nix-prefetch-url --unpack
  # i.e. for the Hexyl repo, use:
  # nix-prefetch-url --unpack https://github.com/Reledia/hexyl.yazi/archive/refs/heads/main.zip

  hexylPlugin = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "hexyl.yazi";
    rev = "4162cb34fa9d4e27251243714c3c19166aa4be95";
    sha256 = "15ci64d29qc6qidnmsmy4ykzfcjdzpz6hx25crsbg1rfad9vqxbj";
  };
in {
  xdg.configFile."yazi/plugins/hexyl.yazi".source = hexylPlugin;

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      log = {
        enabled = true;
      };        

      plugin = {
        append_previewers = [
          { name = "*"; run = "hexyl"; }
        ];
      };

      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
      };

    };

    theme = {
      manager = {
        cwd = { fg = "#85dc85"; };
        hovered = { reversed = true; };
        preview_hovered = { underline = true; };

        find_keyword = {
          fg = "#c6c684";
          bold = true;
          italic = true;
          underline = true;
        };

        find_position = { 
          fg = "#ae81ff";
          bg = "reset";
          bold = true;
          italic = true;
        };

        marker_copied = {
          fg = "#36c692";
          bg = "#36c692";
        };

        marker_cut = {
          fg = "#ff5189";
          bg = "#ff5189";
        };

        marker_marked = {
          fg = "#c6c684";
          bg = "#c6c684";
        };

        marker_selected = {
          fg = "#74b2ff";
          bg = "#74b2ff";
        };

        tab_active = {
          fg = "#080808";
          bg = "#e4e4e4";
        };

        tab_inactive = {
          fg = "#e4e4e4";
          bg = "#323437";
        };

        tab_width = 1;
        count_copied = {
          fg = "#080808";
          bg = "#36c692";
        };

        count_cut = {
          fg = "#080808";
          bg = "#ff5189";
        };

        count_selected = {
          fg = "#080808";
          bg = "#74b2ff";
        };

        border_symbol = "│";
        border_style = { fg = "#949494"; };
      };
      
      status = {
        separator_open = "";
        separator_close = "";

        separator_style = {
          fg = "#323437";
          bg = "#323437";
        };

        mode_normal = {
          fg = "#080808";
          bg = "#74b2ff";
          bold = true;
        };

        mode_select = {
          fg = "#080808";
          bg = "#36c692";
          bold = true;
        };

        mode_unset = {
          fg = "#080808";
          bg = "#ff5189";
          bold = true;
        };

        progress_label = {
          fg = "#e4e4e4";
          bold = true;
        };

        progress_normal = {
          fg = "#74b2ff";
          bg = "#323437";
        };

        progress_error = {
          fg = "#ff5189";
          bg = "#323437";
        };

        permissions_t = { fg = "#74b2ff"; };
        permissions_r = { fg = "#c6c684"; };
        permissions_w = { fg = "#ff5189"; };
        permissions_x = { fg = "#36c692"; };
        permissions_s = { fg = "#949494"; };
      };

      input = {
        border = { fg = "#74b2ff"; };
        title = {};
        value = {};
        selected = { reversed = true; };
      };

      select = {
        border = { fg = "#74b2ff"; };
        active = { fg = "#ae81ff"; };
        inactive = {};
      };

      tasks = {
        border = { fg = "#74b2ff"; };
        title = {};
        hovered = { underline = true; };
      };

      which = {
        mask = { bg = "#323437"; };
        cand = { fg = "#85dc85"; };
        rest = { fg = "#bdbdbd"; };
        desc = { fg = "#ae81ff"; };
        separator = "  ";
        separator_style = { fg = "#949494"; };
      };

      help = {
        on = { fg = "#ae81ff"; };
        run = { fg = "#85dc85"; };
        desc = { fg = "#bdbdbd"; };
        hovered = {
          bg = "#323437";
          bold = true;
        };
        footer = {
          fg = "#323437";
          bg = "#e4e4e4";
        };
      };

      filetype = {
        rules = [
          { mime = "image/*"; fg = "#85dc85"; }
          { mime = "video/*"; fg = "#c6c684"; }
          { mime = "audio/*"; fg = "#c6c684"; }
          { mime = "application/zip"; fg = "#ae81ff"; }
          { mime = "application/gzip"; fg = "#ae81ff"; }
          { mime = "application/x-tar"; fg = "#ae81ff"; }
          { mime = "application/x-bzip"; fg = "#ae81ff"; }
          { mime = "application/x-bzip2"; fg = "#ae81ff"; }
          { mime = "application/x-7z-compressed"; fg = "#ae81ff"; }
          { mime = "application/x-rar"; fg = "#ae81ff"; }
          { name = "*"; fg = "#e4e4e4"; }
          { name = "*/"; fg = "#74b2ff"; }
        ];
      };
    };
  };
}

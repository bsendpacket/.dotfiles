{ pkgs, ... }: {

  programs.neovim = {
    enable = true;

    # Specify plugins
    plugins = with pkgs.vimPlugins; [
      # Add your desired plugins here
      telescope-nvim
      nerdtree
      gruvbox
    ];

    # Use custom configuration
    extraConfig = ''
      colorscheme gruvbox

      " Turn on line numbers
      set number

      " Turn on relative line numbers
      set relativenumber

      " Configure clipboard to use unnamed and unnamedplus
      " This makes yank operations (`y`) copy to the clipboard
      " and allows pasting (`p`) from the clipboard.
      set clipboard+=unnamed,unnamedplus

      " Add additional configuration here if needed for the plugins
      " For example, key bindings or plugin-specific settings

      " NERDTree keybinding to toggle the tree view
      map <C-n> :NERDTreeToggle<CR>

      " Telescope keybindings
      nnoremap <C-p> :Telescope find_files<CR>
      nnoremap <C-f> :Telescope live_grep<CR>
    '';
  };
}

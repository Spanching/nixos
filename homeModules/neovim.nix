{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      pyright
      lua-language-server
      nil
      vscode-langservers-extracted
      gopls

      ripgrep
      fd
      nixfmt-classic
      tree-sitter
      gcc
      nodejs
      lazygit
      python3
      luarocks
      lua
      gnumake
    ];
  };
}

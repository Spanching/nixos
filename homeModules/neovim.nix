{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      # LSP Servers (replacing Mason)
      pyright
      lua-language-server
      nil
      vscode-langservers-extracted

      # External Tools
      ripgrep
      fd
      nixfmt-classic
      tree-sitter
      gcc
      nodejs
      lazygit
      python3
    ];
  };
}

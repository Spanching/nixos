# { pkgs, ... }:
#
# {
#
#   programs.neovim = {
#     enable = true;
#     defaultEditor = true;
#     withPython3 = true;
#     extraPackages = with pkgs; [
#       pyright
#       lua-language-server
#       nil
#       vscode-langservers-extracted
#       gopls
#       tree-sitter
#       gcc
#       nodejs
#       lazygit
#       python3
#       luarocks
#       lua
#       gnumake
#     ];
#   };
# }

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
    pyright
    lua-language-server
    nil
    vscode-langservers-extracted
    gopls
    tree-sitter
    gcc
    nodejs
    lazygit
    python3
    luarocks
    lua
    gnumake
  ];

  home.sessionVariables.EDITOR = "nvim";
}

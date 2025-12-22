{ lib, ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      palette = "catppuccin_frappe";

      format = lib.concatStrings [
        "$kubernetes"
        "$directory"
        "$git_branch"
        "$nix_shell"
        "$python"
        "$docker_context"
        "$aws"
        "$gcloud"
        "$openstack"
        "$azure"
        "$env_var"
        "$crystal"
        "$sudo"
        "$status"
        "$container"
        "$shell"
        "$character"
      ];

      character = {
        success_symbol = "[](bold rosewater)";
        error_symbol = "[](bold red)";
      };

      directory = {
        format = "[$path]($style) ";
        truncation_length = 3;
        style = "fg:peach";
      };

      git_branch = {
        style = "fg:mauve";
      };

      git_status = {
        disabled = true;
      };

      # Python virtual environment
      python = {
        symbol = " ";
        format = "via [$symbol$virtualenv]($style) ";
        # style = "fg:yellow";
      };

      # Nix shell indicator
      nix_shell = {
        symbol = " ";
        format = "via [$symbol$state]($style) ";
        impure_msg = "";
      };

      aws = {
        symbol = "  ";
      };

      conda = {
        symbol = " ";
      };

      dart = {
        symbol = " ";
        format = "via [$symbol]($style)";
      };

      docker_context = {
        symbol = " ";
      };

      elixir = {
        symbol = " ";
        format = "via [$symbol]($style)";
      };

      elm = {
        symbol = " ";
      };

      golang = {
        symbol = " ";
        format = "via [$symbol]($style)";
      };

      hg_branch = {
        symbol = " ";
      };

      java = {
        symbol = " ";
        format = "via [$symbol]($style)";
      };

      julia = {
        symbol = " ";
      };

      memory_usage = {
        symbol = " ";
      };

      nim = {
        symbol = " ";
      };

      nodejs = {
        symbol = " ";
        format = "via [$symbol]($style)";
      };

      package = {
        symbol = " ";
      };

      perl = {
        symbol = " ";
      };

      php = {
        symbol = "ﯣ ";
      };

      ruby = {
        symbol = "ﯣ ";
      };

      rust = {
        format = "via [$symbol]($style)";
      };

      scala = {
        symbol = "ﯣ ";
      };

      shlvl = {
        symbol = "ﯣ ";
      };

      swift = {
        symbol = "ﯣ ";
        format = "via [$symbol]($style)";
      };

      palettes.catppuccin_frappe = {
        rosewater = "#f2d5cf";
        flamingo = "#eebebe";
        pink = "#f4b8e4";
        mauve = "#ca9ee6";
        red = "#e78284";
        maroon = "#ea999c";
        peach = "#ef9f76";
        yellow = "#e5c890";
        green = "#a6d189";
        teal = "#81c8be";
        sky = "#99d1db";
        sapphire = "#85c1dc";
        blue = "#8caaee";
        lavender = "#babbf1";
        text = "#c6d0f5";
        subtext1 = "#b5bfe2";
        subtext0 = "#a5adce";
        overlay2 = "#949cbb";
        overlay1 = "#838ba7";
        overlay0 = "#737994";
        surface2 = "#626880";
        surface1 = "#51576d";
        surface0 = "#414559";
        base = "#303446";
        mantle = "#292c3c";
        crust = "#232634";
      };
    };
  };
}

{ config, pkgs, ... }:

{
  catppuccin.tmux = { 
    enable = true;
    extraConfig = ''
      set -g @catppuccin_window_status_style "rounded"

      set -g status-right-length 100
      set -g status-left-length 100
      set -g status-left ""
      set -g status-right "#{E:@catppuccin_status_application}"
      set -ag status-right "#{E:@catppuccin_status_session}"
    '';
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    clock24 = true;
    shortcut = "space";
    plugins = [
      pkgs.tmuxPlugins.sensible
      pkgs.tmuxPlugins.resurrect
    ];
    extraConfig = ''
      set -g mouse on
      set -g default-terminal "tmux-256color"

      set-option -ga terminal-overrides ",*256col*:Tc:RGB"

      ## Smart window switching for tmux with nvim
      # decide whether we're in a Vim process
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'

      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

      # use PREFIX - to split vertically
      bind - split-window -v -c "#{pane_current_path}"

      # use PREFIX | to split window horizontally and 
      bind | split-window -h -c "#{pane_current_path}"
    '';
  };
}

# tmux settings

{ ... }:

{
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    shortcut = "Space";

    # Replaces ~/.tmux.conf
    extraConfig = ''

# start with window 1 (instead of 0)
set -g base-index 1

# Enable mouse mode (tmux 2.1 and above)
set -g mouse on

# don't rename windows automatically
set-option -g allow-rename off


set-option -g status on
set-option -g status-interval 1
set-option -g status-justify centre
set-option -g status-keys vi
set-option -g status-position bottom
set-option -g status-style fg=colour136,bg=colour235
set-option -g status-left-length 20
set-option -g status-left-style default
set-option -g status-left "#[fg=green]#H #[fg=black]• #[fg=green,bright]#(uname -r)#[default]"
set-option -g status-right-length 140
set-option -g status-right-style default
set-option -g status-right "#[fg=green,bg=default,bright]#(tmux-mem-cpu-load) "
set-option -ag status-right "#[fg=red,dim,bg=default]#(uptime | cut -f 4-5 -d ' ' | cut -f 1 -d ',') "
set-option -ag status-right " #[fg=white,bg=default]%a%l:%M:%S %p#[default] #[fg=blue]%Y-%m-%d"
set-window-option -g window-status-style fg=colour244
set-window-option -g window-status-style bg=default
set-window-option -g window-status-current-style fg=colour166
set-window-option -g window-status-current-style bg=default

    '';
  };
}

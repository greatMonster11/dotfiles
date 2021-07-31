# This tmux statusbar config was created by tmuxline.vim
# on Tue, 01 Nov 2016

set -g status-bg "colour238"
set -g message-command-fg "colour251"
set -g status-justify "left"
set -g status-left-length "100"
set -g status "on"
set -g pane-active-border-fg "colour114"
set -g message-bg "colour239"
set -g status-right-length "100"
set -g status-right-attr "none"
set -g message-fg "colour251"
set -g message-command-bg "colour239"
set -g status-attr "none"
set -g pane-border-fg "colour239"
set -g status-left-attr "none"
setw -g window-status-fg "colour246"
setw -g window-status-attr "none"
setw -g window-status-activity-bg "colour238"
setw -g window-status-activity-attr "none"
setw -g window-status-activity-fg "colour114"
setw -g window-status-separator ""
setw -g window-status-bg "colour238"
set -g status-left "#[fg=colour236,bg=colour114] #S #[fg=colour114,bg=colour238,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=colour239,bg=colour238,nobold,nounderscore,noitalics]#[fg=colour248,bg=colour239] %Y-%m-%d | %H:%M #[fg=colour246,bg=colour239,nobold,nounderscore,noitalics]#[fg=colour238,bg=colour246] #h "
setw -g window-status-format "#[fg=colour246,bg=colour238] #I |#[fg=colour246,bg=colour238] #W "
setw -g window-status-current-format "#[fg=colour238,bg=colour239,nobold,nounderscore,noitalics]#[fg=colour251,bg=colour239] #I |#[fg=colour251,bg=colour239] #W #[fg=colour239,bg=colour238,nobold,nounderscore,noitalics]"

# Plugins
# List of plugins
set -g @plugin 'tmux-plugins/tpm'


# set tmux's TERM
set -g default-terminal tmux-256color
# Mouse fix
set -g mouse on
set -g @plugin 'nhdaly/tmux-better-mouse-mode'
set -g @scroll-speed-num-lines-per-scroll 1
set -g history-limit 30000
# bind -T root WheelUpPane   if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; copy-mode -e; send-keys -M"
# bind -T root WheelDownPane if-shell -F -t = "#{alternate_on}" "send-keys -M" "select-pane -t =; send-keys -M"

# * copy/paste selection
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-copycat'
set -g @plugin 'tmux-plugins/tmux-open'

# * tpm init
# Initialize TMUX plugin manager
run '~/.tmux/plugins/tpm/tpm'

# * shortcuts
set -g prefix M-' '

bind-key s split-window -h # vertical split
bind-key S split-window -v # horizontal split

bind-key J resize-pane -D 5
bind-key K resize-pane -U 5
bind-key H resize-pane -L 5
bind-key L resize-pane -R 5

bind-key M-j resize-pane -D
bind-key M-k resize-pane -U
bind-key M-h resize-pane -L
bind-key M-l resize-pane -R

# Vim style pane selection
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Use Alt-vim keys without prefix key to switch panes
bind -n M-h select-pane -L
bind -n M-j select-pane -D
bind -n M-k select-pane -U
bind -n M-l select-pane -R

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# bricewge
# Shift arrow to switch windows
bind -n M-tab select-pane -t :.+
# bind -n C-tab select-pane -t :.-
# bind -n S-tab next-window

# VIM style
set-window-option -g mode-keys vi
# Tab navigation
bind -n S-up new-window
bind -n S-down kill-window
bind -n S-left prev
bind -n S-right next
bind -n C-left swap-window -t -1
bind -n C-right swap-window -t +1
# Reload config
bind r source-file ~/.tmux.conf\;  display "config reloaded"

# * UI
# ** general
# easier for direct navigation
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on

# ** status bar
set -g status-position top
set -g status-justify left # this concerns the window list
set -g status-left-length "100"
set -g status-right-length "100"

set -g window-status-separator "|"
set -g window-status-format " #I: #W #{?window_flags,#F ,  }"
set -g window-status-current-format " #[bold]#I: #W #F "

# ** styles
# *** general
# copy mode styles
set -g mode-style "bg=COLOR_BACKGROUND,fg=COLOR_FOREGROUND_ALT,bold"
# status line styles
set -g message-style "bg=default,fg=default,bold"

# *** pane
set -g pane-border-style "fg=COLOR_BACKGROUND,bg=COLOR_BACKGROUND"
set -g pane-active-border-style "fg=COLOR_FOREGROUND_ALT,bg=COLOR_BACKGROUND"

# *** status bar
set -g status-style "bg=COLOR_BACKGROUND,fg=COLOR_FOREGROUND_DIM"
set -g window-status-style "fg=COLOR_FOREGROUND_DIM"
set -g window-status-current-style "fg=COLOR_FOREGROUND_ALT,bg=COLOR_BACKGROUND_ALT"
set -g status-left "#[bold]#{?pane_synchronized,#[fg=colour5] sync on ,}#{?pane_in_mode,#[fg=colour4] #{pane_mode}#{?selection_present, selecting,}#{?rectangle_toggle, rectangle,} ,}"
set -g status-right "#[bg=default,fg=yellow]#{?client_prefix,#[fg=colour2]#[bg=default]#[reverse],} #S #{session_id} #{?client_prefix,,}"

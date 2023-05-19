# tmux
- 配置文件`.tmux.conf`
```
unbind '"'
bind - splitw -v -c '#{pane_current_path}'
unbind %
bind \\ splitw -h -c '#{pnae_current_path}'
set -g mouse on
set-option -g default-shell /bin/zsh
```

- 加载配置
	- `ctrl+b`
	- `:`
	- `source-file ~/.tmux.conf`
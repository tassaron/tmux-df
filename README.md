# Tmux-df

Simply puts the output of `df -h` in the Tmux statusbar. Please feel free to submit pull requests with related options and features.


## Format strings (add to tmux statusbar)

* `#{df_avail}`: prints `avail` column for disk mounted as `/`
* `#{df_percent}`: prints `use%` column for disk mounted as `/`
* `#{df_avail_private[1-5]}`: prints `avail` column for disk mounted as defined by `df_cmd_private[1-5]`
* `#{df_percent_private[1-5]}`: prints `use%` column for disk mounted as defined by `df_cmd_private[1-5]`

Define more mounted points such as:
```
set -g @df_cmd_private1 "$HOME/code"
set -g @df_cmd_private2 "/dev"
```


## Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tassaron/tmux-df'

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right` or `status-left`, they should now be visible.


##  Updating with Tmux Plugin Manager

Use TPM update command: `prefix` + <kbd>U</kbd>


## Manual Installation

Clone the repo:

    $ git clone https://github.com/tassaron/tmux-df ~/.tmux/plugins

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/.tmux/plugins/tmux-df/df.tmux

Reload tmux environment:

    $ tmux source-file ~/.tmux.conf

If format strings are added to `status-right` or `status-left`, they should now be visible.


## Manual Updating

Go to cloned location and pull new changes with git:

    $ cd ~/.tmux/plugins/tmux-df && git pull

Reload tmux environment:

    $ tmux source-file ~/.tmux.conf


## Troubleshooting

- Problem with Windows? Your git may be converting line endings to Windows format. [See TPM issue #81 for instructions on how to fix this.](https://github.com/tmux-plugins/tpm/issues/81)


## License

[MIT](LICENSE)

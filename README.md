# Tmux-df

Simply puts the output of `df -h` in the Tmux statusbar. Please feel free to submit pull requests with related options and features.


### Format strings
`#{df_avail}`: prints `avail` column for disk mounted as `/`


### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tassaron/tmux-df'

Hit `prefix + I` to fetch the plugin and source it.

If format strings are added to `status-right` or `status-left`, they should now be visible.

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tassaron/tmux-df ~/.tmux/plugins

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/.tmux/plugins/tmux-df/df.tmux

Reload TMUX environment (type this in terminal)

    $ tmux source-file ~/.tmux.conf

If format strings are added to `status-right` or `status-left`, they should now be visible.


### License

[MIT](LICENSE)

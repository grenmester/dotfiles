# Dotfiles

Elegant dotfiles that are simple to understand and modify.

## Preface

These are some of the dotfiles I use on my [Arch Linux][arch] and
[macOS][macos] environments. An effort has been made to apply programming best
practices to keep these dotfiles organized, simple, and easy to read. The
dotfiles are also commented so they may be used as references or inspiration
when creating personal configurations.

## Overview

* General
  * [Bash][bash] (`~/.bashrc`) - default terminal shell
  * [Zsh][zsh] (`~/.zshrc`) - better version of `bash`
  * [Neovim][neovim] (`~/.vimrc`) - text editor
  * [Tmux][tmux] (`~/.tmux.conf`) - terminal multiplexer
  * [Git][git] (`~/.gitconfig` & `~/.gitignore`) - version control system
* Linux
  * [XMonad][xmonad] (`~/.xmonad/xmonad.hs`) - tiling window manager
  * [Xmobar][xmobar] (`~/.config/xmobar/xmobarrc`) - status bar
  * [Kitty][kitty] (`~/.config/kitty/kitty.conf`) - terminal emulator
  * [Rofi][rofi] (`~/.config/rofi/config.rasi`) - application launcher
  * [Dunst][dunst] (`~/.config/dunst/dunstrc`) - notification daemon
* Miscellaneous
  * Font: [FiraCode Nerd Font][firacode]
  * Colorscheme: [Solarized][solarized]
  * GTK Theme: [Numix Solarized][solarized-gtk]
  * Icon Theme: [Papirus][papirus]

## Features

* Bash
  * default shell for most operating systems
  * use `zsh` instead of `bash` whenever possible
* Zsh
  * improved version of `bash` with better defaults and customization options
  * `zinit` plugin manager with fastest startup time compared to `zplug`,
    `zgen`, and `antigen`
  * `fish`-style syntax highlighting with `zsh-syntax-highlighting`
  * improved reverse history search with `history-search-multi-word`
  * better `ls` aliases with `exa`
  * substring completions using `zstyle` completion system
  * colored man pages
  * displays error code in right prompt
* Neovim
  * `vim-plug` plugin manager faster than `Vundle` and `pathogen`
  * `coc.nvim` for LSP, linting, formatting, completion, and snippet support
  * improved status bar with `lightline.vim`
  * file explorer support with `coc-explorer`
  * backwards compatibility with `vim`
* Tmux
  * `tpm` plugin manager
  * true color support
  * status bar indicates if prefix key is pressed or not
  * shared clipboard between system, terminal emulator, `tmux`, and `neovim`
    with `tmux-yank`
  * saves `tmux` environment to allow for a complete restoration after a system
    restart with `tmux-resurrect`
* Git
  * most common version control system compared with `hg` and `svn`
  * uses `hub`, extension to command-line `git`
  * aliases for commonly run `git` and `hub` commands
  * prettier `log` and `reflog` aliases
  * global `.gitignore` file applied to all `git` repositories
* XMonad
  * dynamic window manager configured in Haskell and an alternative to desktop
    environments
  * uses `XMonad.Util.EZConfig` for keybindings for enhanced readability
  * adjustable screen and window gaps
  * sends internal state information to `xmobar` with `XMonad.Hooks.DynamicLog`
  * multi-monitor support with `xmobar`
* Xmobar
  * status bar most commonly used with `xmonad`
  * displays `xmonad` information such as workspaces, layout, window count, and
    window title
  * uses monitor plugins to display information such as RAM/CPU usage and more
* Kitty
  * fast, cross-platform, GPU-accelerated terminal emulator
  * default ligature support
  * replaces `xterm`
* Rofi
  * drop-in `dmenu` replacement with additional features
  * also functions as window switcher and `ssh` launcher
  * run in `combi` mode to allow several modes to be merged into one list
* Dunst
  * lightweight replacement for the notification-daemons provided by most
    desktop environments
  * includes `dunstify`, an alternative to `notify-send` with more features
    like IDs and actions

## Installation

These instructions are for Arch Linux distributions. I use `yay` to install AUR
packages. For macOS, replacing `pacman -S` with `brew install` will generally
work, assuming you have `brew` installed.

### Zsh

    pacman -S zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

After reloading the shell, run `zinit self-update` to update `zinit` and `zinit
update --all` to update plugins.

Optional utilities:

    pacman -S exa hub

To set `zsh` as your default shell, run ``chsh -s `which zsh` `` and reset your
computer.

### Neovim

For backwards compatibility, we first set up `vim` then `neovim`.

    pacman -S vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Run `:PlugInstall` to install plugins, `:PlugUpdate` to update plugins, and
`:PlugUpgrade` to update `vim-plug`.

    pacman -S neovim python-neovim xclip

    # symlink config directories
    mkdir -p ~/.config
    ln -s ~/.vim ~/.config/nvim
    ln -s ~/.vimrc ~/.config/nvim/init.vim

Run `:checkhealth` and follow the instructions to install the providers. Run
`:PlugInstall` and `:UpdateRemotePlugins` to install `neovim` plugins.

Additional steps for plugins:

    # coc.nvim
    pacman -S nodejs

    # vimtex
    pacman -S texlive-most zathura zathura-pdf-mupdf xdotool python-pip
    pip install neovim-remote

    # vim-instant-markdown
    pacman -S xdg-utils
    yarn global add instant-markdown-d

### Tmux

    pacman -S tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

Run `<prefix>-I` to install plugins and `<prefix>-U` to update plugins.

### Others

* Bash: `pacman -S bash`
* Git: `pacman -S git`
* XMonad: `pacman -S xmonad xmonad-contrib`
* Xmobar: `pacman -S xmobar`
* Kitty: `pacman -S kitty xterm`
* Rofi: `pacman -S rofi dmenu`
* Dunst: `pacman -S dunst libnotify`
* Font: `yay -S nerd-fonts-fira-code`
* GTK Theme: `yay -S gtk-theme-numix-solarized`
* Icon Theme: `pacman -S papirus-icon-theme`

Note that `xterm` and `dmenu` are not required but some programs may use them
as default programs.

Other utilities that I use but don't have dotfiles for in this repository and
might be worth mentioning include `emacs` (text editor), `picom` (compositor),
`vifm` (file manager), `sxiv` (image viewer), and `nitrogen` (wallpaper
setter).

More utilities that I use include `ripgrep`, `htop`, `bat`, `scrot`,
`neofetch`, and `arandr`. Some fun ones include `gotop`, `pipes.sh`, and
`asciiquarium`.

## Additional Remarks

This repository is meant to simply be a collection of dotfiles, not a dotfile
management system. As such, there is no installation script although I'm sure
it wouldn't take long to write one. For an elegant way to store dotfiles,
consider using a [bare repository][bare-repo]. Users are expected to manually
inspect and customize each dotfile. For this reason, specific aliases or
keybindings are not explicitly mentioned in the descriptions. Furthermore as a
matter of personal taste, excellent utilities worth mentioning such as
`oh-my-zsh`, `fzf`, and `pywal` are not included to keep things simple.

## Contributing

Please feel free to contribute in any way that you would like. If you find a
bug or have any questions, [report it][issues]. Contributions through [pull
requests][prs] are also welcome.

[arch]: https://www.archlinux.org
[macos]: https://www.wikipedia.com/en/MacOS

[bash]: https://www.gnu.org/software/bash
[zsh]: http://zsh.sourceforge.net
[neovim]: https://neovim.io
[tmux]: https://github.com/tmux/tmux
[git]: https://git-scm.com
[xmonad]: https://xmonad.org
[xmobar]: https://xmobar.org
[kitty]: https://github.com/kovidgoyal/kitty
[rofi]: https://github.com/davatorium/rofi
[dunst]: https://dunst-project.org

[firacode]: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
[solarized]: https://ethanschoonover.com/solarized
[solarized-gtk]: https://github.com/Ferdi265/numix-solarized-gtk-theme
[papirus]: https://git.io/papirus-icon-theme

[bare-repo]: https://www.atlassian.com/git/tutorials/dotfiles
[issues]: https://github.com/grenmester/dotfiles/issues
[prs]: https://github.com/grenmester/dotfiles/pulls

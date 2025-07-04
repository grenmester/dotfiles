# Dotfiles

Elegant dotfiles that are simple to understand and modify.

## Preface

These are some of the dotfiles I use on my [Arch Linux][arch] and
[macOS][macos] environments. An effort has been made to apply programming best
practices to keep these dotfiles organized, simple, and easy to read. The
dotfiles are also commented so they may be used as references or inspiration
when creating personal configurations.

## Overview

- General
  - [Bash][bash] (`~/.bashrc`) - default terminal shell
  - [Zsh][zsh] (`~/.zshrc`) - better version of `bash`
  - [Vim][vim] (`~/.vimrc`) - text editor
  - [Neovim][neovim] (`~/.config/nvim/init.lua`) - improved version of `vim`
  - [Tmux][tmux] (`~/.tmux.conf`) - terminal multiplexer
  - [Git][git] (`~/.gitconfig` & `~/.gitignore`) - version control system
- Linux
  - [XMonad][xmonad] (`~/.xmonad/xmonad.hs`) - tiling window manager
  - [Xmobar][xmobar] (`~/.config/xmobar/xmobarrc`) - status bar
  - [Kitty][kitty] (`~/.config/kitty/kitty.conf`) - terminal emulator
  - [Rofi][rofi] (`~/.config/rofi/config.rasi`) - application launcher
  - [Dunst][dunst] (`~/.config/dunst/dunstrc`) - notification daemon
- Miscellaneous
  - Font: [FiraCode Nerd Font][firacode]
  - Colorscheme: [Solarized][solarized]
  - GTK Theme: [Numix Solarized][solarized-gtk]
  - Icon Theme: [Papirus][papirus]

### Screenshots

![First Screenshot](img/screenshot1.png)

Here we see `xmonad` in tiling mode with window gaps, `xmobar` on top, and five
`kitty` windows on `zsh` with transparency running `neofetch`, `gotop`,
`asciiquarium`, `cmatrix`, and `pipes.sh`.

![Second Screenshot](img/screenshot2.png)

Here we see `xmonad` with floating windows containing `emacs`, `lxappearance`,
`dunst`, `rofi`, `vifm`, and `kitty` containing a `neovim` instance inside a
`tmux` session.

## Features

- Bash
  - default shell for most operating systems
  - use `zsh` instead of `bash` whenever possible
- Zsh
  - improved version of `bash` with better defaults and customization options
  - `zinit` plugin manager with fastest startup time compared to `zplug`,
    `zgen`, and `antigen`
  - `fish`-style syntax highlighting with `zsh-syntax-highlighting`
  - improved reverse history search with `history-search-multi-word`
  - better `ls` aliases with `eza`
  - substring completions using `zstyle` completion system
  - colored man pages
  - displays error code in right prompt
- Vim
  - `vim-plug` plugin manager faster than `Vundle` and `pathogen`
  - improved status bar with `lightline.vim`
  - additional LSP features when using config in `neovim`
  - `coc.nvim` for LSP, linting, formatting, completion, and snippet support
  - file explorer support with `coc-explorer`
- Neovim
  - `lazy.nvim` plugin manager
  - support for Treesitter, LSP, linting, formatting, completion, and snippets
  - AI integration with `avante.nvim` and `copilot.lua`
  - filesystem navigation with `telescope.nvim` and `neo-tree.nvim`
  - improved status bar with `lualine.vim` and `bufferline.nvim`
  - enhanced UI with `noice.nvim`, `trouble.nvim`, and `which-key.nvim`
  - optional LazyVim config for automatic setup
- Tmux
  - `tpm` plugin manager
  - true color support
  - status bar indicates if prefix key is pressed or not
  - shared clipboard between system, terminal emulator, `tmux`, and `neovim`
    with `tmux-yank`
  - saves `tmux` environment to allow for a complete restoration after a system
    restart with `tmux-resurrect`
- Git
  - most common version control system compared with `hg` and `svn`
  - uses `gh`, extension to command-line `git`
  - aliases for commonly run `git` commands
  - prettier `log` and `reflog` aliases
  - global `.gitignore` file applied to all `git` repositories
- XMonad
  - dynamic window manager configured in Haskell and an alternative to desktop
    environments
  - uses `XMonad.Util.EZConfig` for keybindings for enhanced readability
  - adjustable screen and window gaps
  - sends internal state information to `xmobar` with `XMonad.Hooks.DynamicLog`
  - multi-monitor support with `xmobar`
- Xmobar
  - status bar most commonly used with `xmonad`
  - displays `xmonad` information such as workspaces, layout, window count, and
    window title
  - uses monitor plugins to display information such as RAM/CPU usage and more
- Kitty
  - fast, cross-platform, GPU-accelerated terminal emulator
  - default ligature support
  - replaces `xterm`
- Rofi
  - drop-in `dmenu` replacement with additional features
  - also functions as a window switcher and `ssh` launcher
  - run in `combi` mode to allow several modes to be merged into one list
  - includes a calculator mode and an emoji mode
- Dunst
  - lightweight replacement for the notification-daemons provided by most
    desktop environments
  - includes `dunstify`, an alternative to `notify-send` with more features
    like IDs and actions

## Installation

These instructions are for Arch Linux distributions. I use `paru` to install AUR
packages. For macOS, replacing `pacman -S` with `brew install` will generally
work, assuming you have `brew` installed.

### Zsh

    pacman -S zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

After reloading the shell, run `zinit self-update` to update `zinit` and `zinit
update --all` to update plugins.

To set `zsh` as your default shell, run ``chsh -s `which zsh` `` and reset your
computer.

Optional utilities:

    pacman -S eza github-cli

You may use `gh auth login` to authenticate to GitHub.

### Vim

Note: It is recommended to use `neovim` instead of `vim` as it is more
up-to-date and feature-rich. The `vim` config is left here for historical
purposes.

The `vim` config can also be used in `neovim`. If this is done, additional LSP
features become available to use. For backwards compatibility, we first set up
`vim` then `neovim`.

    pacman -S vim
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Run `:PlugInstall` to install plugins, `:PlugUpdate` to update plugins, and
`:PlugUpgrade` to update `vim-plug`.

If you want to use this config with `neovim` and enable LSP support, you can
follow these steps.

    pacman -S neovim

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

### Neovim

There are two configs here: a vanilla config (`~/.config/nvim/init.lua`) and a
LazyVim config (`~/.config/nvim/lua/plugins/config.lua`). The vanilla config is
recommended if you want to have full control of all configurations and plugins.
The LazyVim config is recommended if you want most things to be automatically
configured and just want to tweak some minor settings.

    pacman -S neovim

If you want to use [LazyVim][lazyvim], a pre-configured `neovim` setup, you need
to install it. If you already have an existing config, you will probably want to
back it up first.

    # required
    mv ~/.config/nvim{,.bak}

    # optional but recommended
    mv ~/.local/share/nvim{,.bak}
    mv ~/.local/state/nvim{,.bak}
    mv ~/.cache/nvim{,.bak}

Once you back up your existing config, you can install LazyVim by running:

    git clone https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git

The plugins should automatically install the first time you open `neovim`.

### Tmux

    pacman -S tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

Run `<prefix> I` to install plugins and `<prefix> U` to update plugins.

### Others

- Bash: `pacman -S bash`
- Git: `pacman -S git openssh`
- XMonad: `pacman -S xmonad xmonad-contrib`
- Xmobar: `pacman -S xmobar`
- Kitty: `pacman -S kitty xterm`
- Rofi: `pacman -S rofi rofi-calc dmenu && paru -S rofi-emoji`
- Dunst: `pacman -S dunst libnotify`
- Font: `paru -S nerd-fonts-fira-code`
- GTK Theme: `paru -S gtk-theme-numix-solarized`
- Icon Theme: `pacman -S papirus-icon-theme`

Note that `xterm` and `dmenu` are not required but some programs may use them
as default programs. If you want to use `ssh` keys for `git`, you will need
`openssh`. The `rofi-calc` and `rofi-emoji` packages are plugins that add modes
to `rofi`.

Other utilities that I use but don't have dotfiles for in this repository and
might be worth mentioning include `emacs` (text editor), `picom` (compositor),
`vifm` (file manager), `sxiv` (image viewer), `nitrogen` (wallpaper setter),
and `pass` (password manager).

More utilities that I use include `ripgrep`, `fd`, `htop`, `bat`, `scrot`,
`fastfetch`, `rofi-pass`, and `arandr`. Some fun ones include `cmatrix`,
`pipes.sh`, and `asciiquarium`.

## Command/Keybinding Reference

### Pacman/Paru Commands

    pacman -Syu               # upgrade repo packages
    pacman -S <package-name>  # install package from the Arch repositories
    paru                      # upgrade AUR packages
    paru -S <package-name>    # install package from the AUR

### Zsh Commands

    zinit update          # update zinit and zsh plugins
    zinit delete --clean  # delete removed zinit plugins

### Vim Commands

    :PlugUpgrade          # update vim-plug
    :PlugInstall          # install vim plugins
    :PlugUpdate           # update vim plugins
    :PlugClean            # delete removed vim plugins

    :UpdateRemotePlugins  # update remote neovim plugins
    :checkhealth          # run neovim healthchecks

### Neovim Commands

    :checkhealth  # run healthchecks
    :Lazy         # manage plugins
    :LspInfo      # check LSP status
    :Mason        # manage external editor tools
    :ConformInfo  # check formatter status
    :LazyExtras   # manage LazyVim extra features

### Tmux Keybindings

    <prefix> I    # install tmux plugins
    <prefix> U    # update tmux plugins
    <prefix> M-u  # delete removed tmux plugins
    <prefix> C-s  # save tmux resurrect session
    <prefix> C-r  # restore tmux resurrect session

## Additional Remarks

This repository is meant to simply be a collection of dotfiles for people to
look through and pick out things they like for their own dotfiles. It is not
meant to be a dotfile management system or a strict configuration that I
recommend everyone to follow. As such, there is no installation script since
that would defeat the purpose and intent of this repository. For an elegant way
to store dotfiles, consider using a [bare repository][bare-repo]. Users are
expected to manually inspect and customize each dotfile. For this reason,
specific aliases or keybindings are not explicitly mentioned in the
descriptions. Furthermore as a matter of personal taste, excellent utilities
worth mentioning such as `oh-my-zsh`, `fzf`, and `pywal` are not included to
keep things simple.

## Contributing

Please feel free to contribute in any way that you would like. If you find a
bug or have any questions, [report it][issues]. Contributions through [pull
requests][prs] are also welcome.

[arch]: https://www.archlinux.org
[macos]: https://www.wikipedia.com/en/MacOS
[bash]: https://www.gnu.org/software/bash
[zsh]: http://zsh.sourceforge.net
[vim]: https://www.vim.org
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
[lazyvim]: https://www.lazyvim.org
[bare-repo]: https://www.atlassian.com/git/tutorials/dotfiles
[issues]: https://github.com/grenmester/dotfiles/issues
[prs]: https://github.com/grenmester/dotfiles/pulls

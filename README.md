# Welcome

These are the dotfiles I use on my laptop, things might look a bit big on a standard desktop screen I don't know.

The `awesome` configuration is built from [modular-awm-default](https://github.com/Gwynsav/modular-awm-default).

The `nvim` configuration is built from [kickstart](https://github.com/nvim-lua/kickstart.nvim).

This repository is designed to make it easy to use [stow](https://www.gnu.org/software/stow/).

# Installation

## Dependencies

These are the dependencies for the `awesome` config:

- `alsa`
- `brightnessctl`
- `i3lock`
- `picom`

These are the dependencies for the `nvim` config:

- `markdownlint-cli`

And there might be others I don't remember.

## Steps

1. [Install awesome from GitHub](https://www.reddit.com/r/awesomewm/comments/xi6ab5/installing_awesomewm).
2. Install dependencies.
The process should be similar for other distributions, but you’ll need to use your distribution’s package manager.
3. Clone the repository using `git clone --recurse-submodules -j8 git@github.com:lenymrq/dotfiles.git` (otherwise you will not clone the submodules and the `awesome` will not work).
4. If you cloned the repository in `/home/user/<repository directory>` then you can simply run `stow <directory name>` (for example `stow awesome` to sync the `awesome` config). Otherwise, you will have to run `stow -t /home/user` (I actually don't know I never tested but it should be something like this).

For `awesome`, you absolutely need the git version, stable release will not work.

# TODO

- `README`: Add screenshots.

# Welcome

These are the dotfiles I use on my laptop, things might look a bit big on a standard desktop screen I don't know.

I use [awesome](https://awesomewm.org/) as my main window manager and [i3](https://i3wm.org/) as a fallback if everything goes to hell.

The `awesome` configuration is built from [modular-awm-default](https://github.com/Gwynsav/modular-awm-default).

The `nvim` configuration is built from [kickstart](https://github.com/nvim-lua/kickstart.nvim).

This repository is designed to make it easy to use [stow](https://www.gnu.org/software/stow/).

# Installation

## Dependencies

These are the dependencies for the `awesome` config

- `alsa`
- `brightnessctl`
- `i3lock`

There are a few dependencies for the nvim config

- `markdownlint-cli`

And there might be others I don't remember

## Steps

1. [Install awesome from GitHub](https://www.reddit.com/r/awesomewm/comments/xi6ab5/installing_awesomewm).
2. Install dependencies: `sudo dnf install alsa-utils alsa-lib brightnessctl i3lock`.  
   The rest of the dependencies should come preinstalled with Fedora. If not, just install them.

The process should be similar for other distributions, but you’ll need to use your distribution’s package manager.

The only package that requires a specific version is `awesome`—you need the [version from GitHub](https://github.com/awesomeWM/awesome), as the stable release will not work.

# TODO

- `awesome`: Move away from `rofi` and build my own app launcher (or extend `awesome`'s default one).
- `README`: Add screenshots.

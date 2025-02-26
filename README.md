# Welcome

These are the dotfiles I use on my laptop, things might look a bit big on a standard desktop screen.

The `awesome` configuration is a modified version of [gwileful](https://github.com/Gwynsav/gwileful).

# Installation

## Dependencies

- `pulseaudio`
- `networkmanager`
- `brightnessctl`
- `playerctl`
- `i3lock`
- `rofi`

_Optional_:

- `picom`

## Steps

1. [Install awesome from GitHub](https://www.reddit.com/r/awesomewm/comments/xi6ab5/installing_awesomewm).
2. Install dependencies: `sudo dnf install blueman brightnessctl playerctl i3lock rofi picom`.  
   The rest of the dependencies should come preinstalled with Fedora. If not, just install them.

Check that the default apps are the ones you want to use. You can change them in `awesome/.config/awesome/config/apps.lua`.

The process should be similar for other distributions (unless you’re using `nix` 🤣), but you’ll need to use your distribution’s package manager.

The only package that requires a specific version is `awesome`—you need the [version from GitHub](https://github.com/awesomeWM/awesome), as the stable release will not work.

# TODO

- `awesome`: Add animations for the tag list and other UI elements.

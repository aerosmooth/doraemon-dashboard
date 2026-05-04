# Doraemon LazyVim Dashboard

This adds a random pixel-art dashboard to LazyVim's `snacks.nvim` dashboard.

## Install

```sh
git clone <repo-url>
cd doraemon-dashboard
./install.sh
```

Do not use `sudo`. This is user-level Neovim config and installs into `~/.config/nvim`.

## Files Installed

```text
~/.config/nvim/lua/plugins/zzz_doraemon_dashboard.lua
~/.config/nvim/scripts/random_dashboard.py
~/.config/nvim/scripts/arts.py
```

## How It Works

`zzz_doraemon_dashboard.lua` overrides the `snacks.nvim` dashboard after other `snacks.lua` files have loaded.

`random_dashboard.py --sizes` reports each art size, so the Lua config can set the dashboard `height` and `width` dynamically. Then Lua runs `random_dashboard.py --index N` to render the selected art.

Edit `scripts/arts.py` to add or change pixel art.

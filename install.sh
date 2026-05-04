#!/usr/bin/env sh

set -eu

if [ "$(id -u)" -eq 0 ]; then
  echo "Do not run this installer with sudo."
  echo "This installs user-level Neovim config under ~/.config/nvim."
  exit 1
fi

src_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
nvim_config="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
plugin_dir="$nvim_config/lua/plugins"
script_dir="$nvim_config/scripts"
timestamp=$(date +%Y%m%d-%H%M%S)

backup_if_needed() {
  src=$1
  dest=$2

  if [ -f "$dest" ] && ! cmp -s "$src" "$dest"; then
    cp "$dest" "$dest.backup.$timestamp"
    echo "Backed up existing $(basename "$dest")"
  fi
}

install_file() {
  src=$1
  dest=$2

  backup_if_needed "$src" "$dest"
  cp "$src" "$dest"
  echo "Installed $dest"
}

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 is required but was not found."
  exit 1
fi

mkdir -p "$plugin_dir" "$script_dir"

install_file "$src_dir/scripts/random_dashboard.py" "$script_dir/random_dashboard.py"
install_file "$src_dir/scripts/arts.py" "$script_dir/arts.py"
install_file "$src_dir/lua/plugins/zzz_doraemon_dashboard.lua" "$plugin_dir/zzz_doraemon_dashboard.lua"

chmod +x "$script_dir/random_dashboard.py"

echo
echo "Doraemon dashboard installed."
echo "Open nvim, or run :lua Snacks.dashboard.update() if a dashboard is already open."

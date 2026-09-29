# Copies the contents of home/ into the machine's home directory.
# Anything that would be overwritten is backed up first.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOME_SRC="$DOTFILES_DIR/home"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d%H%M%S)"

echo "Copying dotfiles from $HOME_SRC to $HOME"

for item in "$HOME_SRC"/* "$HOME_SRC"/.[!.]*; do
  [ -e "$item" ] || continue
  name="$(basename "$item")"
  dest="$HOME/$name"

  if [ -e "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up existing $dest -> $BACKUP_DIR/$name"
    mv "$dest" "$BACKUP_DIR/$name"
  fi

  echo "Copying $name -> $dest"
  cp -R "$item" "$dest"
done

echo "Done. Backups (if any) saved to $BACKUP_DIR"

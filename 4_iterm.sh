# Installs all iTerm2 profiles in iterm2/*.json as iTerm2 Dynamic Profiles,
# and makes MoDev.json's profile the default for new windows/tabs.
#
# Dynamic Profiles are picked up by iTerm2 automatically (no manual
# Preferences > Profiles > Import needed), even while iTerm2 is running.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"

mkdir -p "$DEST_DIR"
for profile in "$DOTFILES_DIR"/iterm2/*.json; do
  cp "$profile" "$DEST_DIR/$(basename "$profile")"
  echo "Installed iTerm2 dynamic profile -> $DEST_DIR/$(basename "$profile")"
done

GUID=$(python3 -c "import json; print(json.load(open('$DOTFILES_DIR/iterm2/MoDev.json'))['Profiles'][0]['Guid'])")

if pgrep -x iTerm2 > /dev/null; then
  echo "iTerm2 is running - the profile is now available under Preferences > Profiles,"
  echo "but it must be set as default from there (Other Actions > Set as Default) since"
  echo "iTerm2 may overwrite an externally-set default while it's open."
else
  defaults write com.googlecode.iterm2 "Default Bookmark Guid" -string "$GUID"
  echo "Set '$GUID' (MoDev.json) as the default iTerm2 profile."
fi

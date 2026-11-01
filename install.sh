#!/usr/bin/env bash
# Instala labvm en ~/.local/bin y el autocompletado de zsh
set -euo pipefail
cd "$(dirname "$(realpath "$0")")"

mkdir -p "$HOME/.local/bin" "$HOME/.config/labvm"
install -m 755 labvm "$HOME/.local/bin/labvm"
install -m 644 completion.zsh "$HOME/.config/labvm/completion.zsh"
echo "✔ labvm instalado en ~/.local/bin/labvm"

LINEA='[[ -f ~/.config/labvm/completion.zsh ]] && source ~/.config/labvm/completion.zsh'
if [[ -f "$HOME/.zshrc" ]] && ! grep -qF 'labvm/completion.zsh' "$HOME/.zshrc"; then
  echo "$LINEA" >> "$HOME/.zshrc"
  echo "✔ Autocompletado añadido a ~/.zshrc (abre una terminal nueva)"
fi

case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;;
  *) echo "! Añade ~/.local/bin a tu PATH:  export PATH=\"\$HOME/.local/bin:\$PATH\"" ;;
esac

for dep in VBoxManage 7z; do
  command -v "$dep" >/dev/null || echo "! Falta $dep (VirtualBox / p7zip-full)"
done

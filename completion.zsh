# Autocompletado de labvm: ofrece los .zip de ~/Descargas y los de la carpeta actual
_labvm() {
  local -a zips
  zips=( ${LABVM_DESCARGAS:-$HOME/Descargas}/*.(zip|ZIP)(N:t) )
  _arguments \
    '-n[red de la VM]:red:(bridged nat hostonly intnet original)' \
    '-h[ayuda]' \
    '*:zip:->zip'
  [[ $state == zip ]] && { compadd -a zips; _files -g '*.(zip|ZIP)'; }
}
compdef _labvm labvm

# labvm

Monta en **VirtualBox** máquinas virtuales de laboratorio que vienen en un `.zip` (HackMyVM, VulnHub, cursos…) con un solo comando, y lo **borra todo al pulsar Ctrl+C**.

```bash
labvm maquina.zip
```

1. Busca el zip en la carpeta actual o en `~/Descargas`. Puedes omitir el `.zip`.
2. Crea la carpeta `~/VMs/labs/<nombre>/` y mueve el zip dentro.
3. Lo descomprime y detecta la máquina:
   - `.ova` / `.ovf` → la importa
   - `.vbox` → la registra
   - solo un disco (`.vmdk`, `.vdi`, `.vhd`, `.vhdx`) → crea una VM nueva (2 GB RAM, 2 CPU)
   - otro comprimido dentro → lo descomprime también
4. Pone la red en **adaptador puente** y arranca la VM.
5. Se queda esperando. Con **Ctrl+C** (o al cerrar la terminal) apaga la VM, la elimina de VirtualBox con sus discos y borra la carpeta y el zip.

## Instalación

```bash
git clone https://github.com/MrDalcove/labvm.git
cd labvm
./install.sh
```

El instalador copia `labvm` a `~/.local/bin` y activa el autocompletado con Tab en zsh (al escribir `labvm ` y pulsar Tab salen los zips de `~/Descargas`).

**Requisitos:** Linux, VirtualBox (`VBoxManage`) y `7z` (`p7zip-full`) o `unzip`.

## Uso

```bash
labvm maquina.zip          # monta esa máquina y espera a Ctrl+C
labvm maquina              # igual, sin escribir .zip
labvm                      # vigila ~/Descargas y monta cada .zip nuevo que se descargue
labvm -n nat maquina.zip   # cambia la red
labvm -h                   # ayuda
```

Redes con `-n`: `bridged` (por defecto), `nat`, `hostonly`, `intnet`, `original` (la que traiga la máquina).

### Variables de entorno

| Variable | Por defecto | Para qué |
|---|---|---|
| `LABVM_DESCARGAS` | `~/Descargas` | carpeta donde busca/vigila los zips |
| `LABVM_RAIZ` | `~/VMs/labs` | dónde crea las carpetas de laboratorio |
| `LABVM_RED` | `bridged` | red por defecto |
| `LABVM_TIPO` | `gui` | modo de arranque (`gui`, `headless`, `separate`) |

Ejemplo para un sistema en inglés: `export LABVM_DESCARGAS=~/Downloads`

## Seguridad

- Solo borra lo que crea en esta sesión y solo dentro de `LABVM_RAIZ`. Tus otras VMs no se tocan.
- Si matas el proceso con `kill -9` o se apaga el equipo, no le da tiempo a limpiar. Borra a mano la VM y la carpeta en `~/VMs/labs`.
- Las máquinas de laboratorio suelen ser vulnerables a propósito y en modo puente quedan visibles en tu red local. Si no quieres eso, usa `-n hostonly` o `-n intnet`.

## Licencia

MIT

#!/bin/bash

# Agente de Limpieza (Flush Agent)
# Este script busca y elimina archivos de snapshot duplicados en la carpeta /snapshots,
# conservando solo la copia más antigua de cada grupo de duplicados.

echo "🚀 Iniciando Flush_AGENT..."

# --- 1. Definir el Directorio de Trabajo ---
SNAPSHOT_DIR="snapshots"

if [ ! -d "$SNAPSHOT_DIR" ]; then
  echo "📂 El directorio '$SNAPSHOT_DIR' no existe. No hay nada que limpiar." >&2
  exit 0
fi

echo "🔍 Escaneando archivos en '$SNAPSHOT_DIR'..."

# --- 2. Encontrar y Eliminar Duplicados ---
# Usamos un archivo temporal para mapear checksums a nombres de archivo
TMP_FILE=$(mktemp)
# El -t en ls ordena los archivos por fecha de modificación (el más antiguo primero)
# por lo que siempre conservaremos la primera entrada que encontremos.
find "$SNAPSHOT_DIR" -type f -name "*.md" -print0 | xargs -0 ls -t | xargs -I {} md5sum "{}" > "$TMP_FILE"

# Usamos un array asociativo para rastrear los checksums que ya hemos visto
declare -A seen_checksums

# Leemos el archivo temporal línea por línea
while IFS= read -r line; do
  checksum=$(echo "$line" | awk '{print $1}')
  file_path=$(echo "$line" | awk '{$1=""; print $0}' | sed 's/^ *//') # Extraer el path

  if [[ -n "${seen_checksums[$checksum]}" ]]; then
    # Si ya hemos visto este checksum, el archivo es un duplicado y lo borramos.
    echo "  - Eliminando duplicado: $file_path"
    rm "$file_path"
  else
    # Si es la primera vez que vemos este checksum, lo marcamos como visto.
    seen_checksums[$checksum]=1
  fi
done < "$TMP_FILE"

# --- 3. Limpieza Final ---
rm "$TMP_FILE"

echo "✅ ¡Limpieza de snapshots duplicados completada!"

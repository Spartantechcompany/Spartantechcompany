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

# --- 2. Encontrar y Eliminar Duplicados (Revisado) ---
echo "🔍 Escaneando archivos en '$SNAPSHOT_DIR'..."

# Create a temporary file to store checksums of files we've decided to keep
KEPT_CHECKSUMS_FILE=$(mktemp)

# Find all markdown files in the snapshots directory, sorted by modification time (oldest first)
# This ensures that when we encounter a duplicate checksum, the file we're currently processing
# is *newer* than the one we've already seen (and kept).
find "$SNAPSHOT_DIR" -type f -name "*.md" -print0 | xargs -0 ls -t | while IFS= read -r file_path; do
    checksum=$(md5sum "$file_path" | awk '{print $1}')

    # Check if this checksum has already been seen (meaning we've kept an older file with this content)
    if grep -q "^$checksum$" "$KEPT_CHECKSUMS_FILE"; then
        echo "  - Eliminando duplicado: $file_path"
        rm "$file_path"
    else
        # This is the first time we've seen this checksum (or it's a unique file), so keep it
        echo "$checksum" >> "$KEPT_CHECKSUMS_FILE"
    fi
done

# --- 3. Limpieza Final ---
rm "$KEPT_CHECKSUMS_FILE"

echo "✅ ¡Limpieza de snapshots duplicados completada!"

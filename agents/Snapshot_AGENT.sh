#!/bin/bash

# Agente de Snapshot
# Este script genera un resumen de los cambios, lo guarda en un archivo MD,
# y sube todo el trabajo a GitHub.

echo "🚀 Iniciando Snapshot_AGENT..."

# --- 1. Definir Nombres y Rutas ---
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
SNAPSHOT_DIR="snapshots"
SNAPSHOT_FILE="$SNAPSHOT_DIR/snapshot_$TIMESTAMP.md"
COMMIT_MESSAGE="snapshot: Archivo de trabajo del $TIMESTAMP"

# --- 2. Crear Directorio de Snapshots ---
# Nos aseguramos de que la carpeta /snapshots exista.
mkdir -p $SNAPSHOT_DIR
echo "📂 Directorio de snapshots verificado."

# --- 3. Generar el Resumen en Markdown ---
echo "📝 Creando resumen de cambios en $SNAPSHOT_FILE..."

# Crear/Sobrescribir el archivo con el título
echo "# 📸 Snapshot - $TIMESTAMP" > "$SNAPSHOT_FILE"
# Añadir el resto del contenido
echo "" >> "$SNAPSHOT_FILE"
echo "## Estado de Git" >> "$SNAPSHOT_FILE"
echo "A continuación se muestra el resultado de 'git status --short':" >> "$SNAPSHOT_FILE"
echo "" >> "$SNAPSHOT_FILE"
echo "```" >> "$SNAPSHOT_FILE"
git status --short >> "$SNAPSHOT_FILE"
echo "```" >> "$SNAPSHOT_FILE"


# --- 4. Ejecutar Comandos de Git ---
echo "🔄 Sincronizando con GitHub..."

# Añadir todos los archivos al área de preparación
git add .
echo "  - Archivos añadidos al commit."

# Hacer commit con un mensaje estandarizado
git commit -m "$COMMIT_MESSAGE"
echo "  - Commit creado con el mensaje: '$COMMIT_MESSAGE'"

# Subir los cambios al repositorio remoto
git push
echo "  - Cambios subidos a la rama principal."

# --- 5. Finalizar ---
echo "✅ ¡Snapshot completado y sincronizado con éxito!"
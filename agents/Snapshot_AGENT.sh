#!/bin/bash

# Agente de Snapshot v3
# Este script sincroniza los cambios remotos, LUEGO genera un resumen de los cambios locales,
# y finalmente sube todo el trabajo a GitHub.

echo "🚀 Iniciando Snapshot_AGENT v3..."

# --- 1. Sincronizar con Repositorio Remoto (Paso Crítico) ---
echo "🔄 Sincronizando con GitHub..."
echo "  - Descargando cambios remotos (git pull --rebase)..."
git pull --rebase

# --- 2. Definir Nombres y Rutas ---
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
SNAPSHOT_DIR="snapshots"
SNAPSHOT_FILE="$SNAPSHOT_DIR/snapshot_$TIMESTAMP.md"
COMMIT_MESSAGE="snapshot: Archivo de trabajo del $TIMESTAMP"

# --- 3. Crear Directorio de Snapshots ---
mkdir -p $SNAPSHOT_DIR
echo "📂 Directorio de snapshots verificado."

# --- 4. Generar el Resumen en Markdown ---
echo "📝 Creando resumen de cambios en $SNAPSHOT_FILE..."
echo "# 📸 Snapshot - $TIMESTAMP" > "$SNAPSHOT_FILE"
echo "" >> "$SNAPSHOT_FILE"
echo "## Estado de Git" >> "$SNAPSHOT_FILE"
echo "A continuación se muestra el resultado de 'git status --short':" >> "$SNAPSHOT_FILE"
echo "" >> "$SNAPSHOT_FILE"
echo "```" >> "$SNAPSHOT_FILE"
git status --short >> "$SNAPSHOT_FILE"
echo "```" >> "$SNAPSHOT_FILE"


# --- 5. Ejecutar Comandos de Git ---
# Añadir todos los archivos al área de preparación
echo "  - Añadiendo archivos locales al commit..."
git add .

# Hacer commit con un mensaje estandarizado
# Usamos || true para que el script no falle si no hay nada que commitear
git commit -m "$COMMIT_MESSAGE" || true
echo "  - Commit creado con el mensaje: '$COMMIT_MESSAGE'"

# Subir los cambios al repositorio remoto
echo "  - Subiendo cambios a la rama principal (git push)..."
git push

# --- 6. Finalizar ---
echo "✅ ¡Snapshot completado y sincronizado con éxito!"
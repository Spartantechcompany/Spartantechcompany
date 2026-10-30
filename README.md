# 🤖 Agent-Driven Workspace

¡Hola! 👋 Este repositorio es un espacio de trabajo experimental para explorar un nuevo paradigma de desarrollo: la orquestación de tareas complejas a través de **agentes de IA** directamente desde la terminal, con **Google Gemini** como motor principal.

📊 **Snapshots totales creados:** <!-- SNAPSHOT_COUNT_START -->10<!-- SNAPSHOT_COUNT_END -->

## El Concepto de "Agentes"

Un "agente" en este proyecto es un script automatizado diseñado para realizar una secuencia de tareas. Estos agentes viven dentro del repositorio (en la carpeta `/agents`) y pueden ser ejecutados y actualizados para expandir sus capacidades.

### Agentes Actuales:
*   **Snapshot_AGENT:** Automatiza el proceso de guardar el trabajo. Genera un resumen de los cambios, lo empaqueta en un archivo de snapshot y sincroniza todo el estado del proyecto con GitHub.

### Demostración del Agente

```shell
$ bash agents/Snapshot_AGENT.sh

🚀 Iniciando Snapshot_AGENT...
📂 Directorio de snapshots verificado.
📝 Creando resumen de cambios...
🔄 Sincronizando con GitHub...
  - Archivos añadidos al commit.
  - Commit creado con el mensaje: 'snapshot: Archivo de trabajo del 2025-10-29'
  - Cambios subidos a la rama principal.
✅ ¡Snapshot completado y sincronizado con éxito!
```

## Visión del Proyecto

El objetivo es transformar la terminal en una interfaz de conversación inteligente, donde los flujos de trabajo (desde hacer un commit hasta interactuar con servicios en la nube) son manejados por agentes especializados, haciendo el proceso de desarrollo más rápido, intuitivo y poderoso.

## 🤝 Co-Creación

Este proyecto es una colaboración entre **Spartantech** y la IA conversacional de **Google Gemini**, explorando juntos el futuro del desarrollo agéntico.

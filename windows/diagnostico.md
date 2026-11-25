# Diagnóstico en Codex de VS Code

Para verificar RTK en cada PC, sigue primero la [guía de instalación](instalacion.md). Abre un chat nuevo de Codex en VS Code en un repositorio Git. Pídele al agente que ejecute cada comando **por separado**, en este orden.

## 1. Comprueba el acceso al ejecutable por ruta absoluta

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
```

**Resultado esperado**. El agente muestra la versión de RTK desde el sandbox.

**Lo que observamos**. La copia en `AppData\Local\Programs\RTK` funcionaba en PowerShell normal, pero el sandbox no pudo ejecutarla por ruta absoluta. Con la copia en `C:\Program Files\RTK\rtk.exe`, la prueba sí funcionó.

## 2. Comprueba qué ejecutable resuelve el agente

```powershell
(Get-Command rtk -CommandType Application -ErrorAction Stop).Source
```

**Resultado esperado**. El `Path` efectivo del agente permite resolver `rtk` como `C:\Program Files\RTK\rtk.exe`.

**Lo que observamos**. La terminal aislada podía ejecutar RTK por ruta absoluta, pero fallaba al buscar `rtk` por nombre. Si el agente sigue heredando un `Path` anterior, cierra sesión en Windows, vuelve a iniciarla y repite las comprobaciones desde un chat nuevo.

## 3. Comprueba que el hook reescribe el comando y devuelve el estado

Pide el comando tal como está escrito, sin prefijo.

```powershell
git status --short --branch
```

**Resultado esperado**. El hook reescribe el comando y la ejecución devuelve el estado del repositorio.

**Lo que observamos**. En la prueba inicial, el hook reescribió `git status` como `rtk git status`. La ejecución falló porque la terminal aislada no resolvía `rtk` por nombre. Para dar esta prueba por completada, comprueba tanto la reescritura como el resultado del comando.

## Consultar estadísticas

Si quieres consultar estadísticas, ejecuta `rtk gain` en PowerShell normal. Es opcional.

## Plugins opcionales

Las pruebas de esta sección quedan pendientes hasta que las confirmes en Codex de VS Code.

### Context7

Después de [instalar Context7](instalacion.md#context7), abre un chat nuevo en un proyecto Angular cuyo `package.json` declare `@angular/core`. Envía esta petición.

> Lee `package.json` para identificar la versión de `@angular/core`. Usa Context7 para consultar cómo declarar un input obligatorio con `input.required()` en esa versión. Dame un ejemplo mínimo e indica qué documentación y versión recuperaste. Si Context7 devuelve documentación general o de otra versión, indícalo. No modifiques archivos.

- **Integración MCP**. Queda verificada si en la actividad del chat aparecen llamadas a Context7, como `resolve-library-id` y `query-docs`.
- **Versión de la documentación**. Registra por separado si corresponde a la que pide el proyecto, si es documentación general o si corresponde a otra versión.

### Superpowers

Después de [instalar Superpowers](instalacion.md#superpowers), realiza las comprobaciones por separado.

#### Activación automática

Abre un chat nuevo en el repositorio `codex-setup` y envía esta petición sin mencionar Superpowers.

> Quiero una guía rápida para comprobar `codex-setup` en un PC nuevo. Revisa el README y las guías de Windows. Ayúdame a decidir si conviene añadir la lista de comprobación al README o a la guía de diagnóstico. Antes de editar, explícame las opciones, recomiéndame una y espera mi decisión.

Busca en la actividad del chat que se haya cargado una skill de Superpowers, por ejemplo `brainstorming`. Una pregunta o un plan también podrían venir del `AGENTS.md` global. Si la actividad no muestra la carga, deja la activación automática como pendiente de confirmar.

#### Activación explícita

Si la activación automática queda sin confirmar, abre otro chat en `codex-setup`. Busca `brainstorming` en el selector de skills, selecciónala y repite la petición. Comprueba en la actividad que se haya cargado la skill de Superpowers y registra este resultado por separado.

# Ahorro de contexto y respuestas

## RTK

RTK reduce la salida de comandos de terminal que llega al contexto. El instalador usa el ZIP oficial para Windows x64.

### Instala RTK en PowerShell como administrador

Abre **PowerShell como administrador**, sitúate en la raíz del repositorio clonado y ejecuta el [instalador de RTK](install-rtk.ps1).

```powershell
.\windows\install-rtk.ps1
```

El script descarga el ZIP oficial, comprueba la versión del ejecutable extraído, lo copia a `C:\Program Files\RTK\` y añade esa carpeta al `Path` del sistema si hace falta.

Si ya existe `rtk.exe` en el destino, el script se detiene. Para reemplazar esa copia, renómbrala como respaldo antes de volver a ejecutar el instalador.

**Lo que observamos.** La primera ejecución sin permisos de administrador falló al crear la carpeta de RTK.

### Registra el hook en PowerShell normal

Vuelve a **PowerShell normal** con tu cuenta habitual. Comprueba la versión por ruta absoluta y registra el hook global de Codex para esa cuenta.

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
& 'C:\Program Files\RTK\rtk.exe' init -g --codex
```

### Habilita y verifica el hook en VS Code

1. Cierra todas las ventanas de VS Code y vuelve a abrirlo.
2. Habilita el hook `PreToolUse` de RTK si está pendiente. En la interfaz de Codex que usamos apareció en **User config → All projects**.
3. Abre un chat nuevo de Codex en un repositorio Git y sigue las [comprobaciones de RTK](#verificar-rtk-en-vs-code).

### Verificar RTK en VS Code

Para verificar RTK en cada PC, sigue primero los pasos de instalación anteriores. Abre un chat nuevo de Codex en VS Code en un repositorio Git. Pídele al agente que ejecute cada comando **por separado**, en este orden.

#### 1. Comprueba el acceso al ejecutable por ruta absoluta

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
```

**Resultado esperado**. El agente muestra la versión de RTK desde el sandbox.

**Lo que observamos**. La copia en `AppData\Local\Programs\RTK` funcionaba en PowerShell normal, pero el sandbox no pudo ejecutarla por ruta absoluta. Con la copia en `C:\Program Files\RTK\rtk.exe`, la prueba sí funcionó.

#### 2. Comprueba qué ejecutable resuelve el agente

```powershell
(Get-Command rtk -CommandType Application -ErrorAction Stop).Source
```

**Resultado esperado**. El `Path` efectivo del agente permite resolver `rtk` como `C:\Program Files\RTK\rtk.exe`.

**Lo que observamos**. La terminal aislada podía ejecutar RTK por ruta absoluta, pero fallaba al buscar `rtk` por nombre. Si el agente sigue heredando un `Path` anterior, cierra sesión en Windows, vuelve a iniciarla y repite las comprobaciones desde un chat nuevo.

#### 3. Comprueba que el hook reescribe el comando y devuelve el estado

Pide el comando tal como está escrito, sin prefijo.

```powershell
git status --short --branch
```

**Resultado esperado**. El hook reescribe el comando y la ejecución devuelve el estado del repositorio.

**Lo que observamos**. En la prueba inicial, el hook reescribió `git status` como `rtk git status`. La ejecución falló porque la terminal aislada no resolvía `rtk` por nombre. Para dar esta prueba por completada, comprueba tanto la reescritura como el resultado del comando.

#### Consultar estadísticas

Si quieres consultar estadísticas, ejecuta `rtk gain` en PowerShell normal. Es opcional.

## Context Mode v2

Context Mode es opcional. Permite indexar salidas grandes de herramientas y recuperar solo los fragmentos necesarios para la tarea.

### Requisitos y cambio de Node con NVM para Windows

Context Mode v2 requiere Node.js 24.15.0 o posterior. En Windows, sus herramientas de shell también requieren Git for Windows.

Antes del cambio, el equipo tenía Node.js 22.14.0. Con NVM para Windows, instala la versión 24.15.0 en paralelo. Elegimos esa versión porque es la mínima requerida. Comprueba cuál queda activa con la salida de `node --version`.

Ejecuta estos comandos en **PowerShell normal**. Si `nvm use` falla por permisos, repite ese comando desde **PowerShell como administrador**. Vuelve a PowerShell normal para las comprobaciones.

```powershell
nvm install 24.15.0
nvm use 24.15.0
node --version
git --version
codex --version
```

Si `codex --version` falla después de cambiar de Node, reinstala en **PowerShell normal** la versión de Codex CLI que teníamos en el inventario y compruébala.

```powershell
npm install -g @openai/codex@0.172.0
codex --version
```

Node.js 22.14.0 sigue disponible con `nvm use 22.14.0`. Si vas a usar Context Mode, asegúrate de que el proceso de Codex encuentre Node.js 24.15.0 o posterior.

### Instalación y confianza de los hooks

Ejecuta estos comandos en **PowerShell normal**.

```powershell
codex plugin marketplace add mksglu/context-mode
codex plugin add context-mode@context-mode
npm install -g context-mode
context-mode setup --agents codex
context-mode doctor
```

Si `doctor` muestra `4 of 4 context-mode plugin hooks untrusted` y pregunta **Fix codex now?**, selecciona **Yes** para que ejecute `context-mode setup --agents codex`. Después, vuelve a ejecutar `context-mode doctor`. En nuestro caso, la fila `codex` pasó de `FAIL` a `PASS` tras el arreglo.

Cierra y vuelve a abrir VS Code. Abre un chat nuevo de Codex y sigue la [prueba de Context Mode](#verificar-context-mode). Usa `context-mode doctor` para verificar la instalación o diagnosticar fallos. Puedes omitirlo al iniciar una sesión normal.

### Verificar Context Mode

**Prueba completada en Codex de VS Code.** Después de instalar Context Mode, puedes repetirla en un chat nuevo, sin un log real. Envía esta petición.

> Usa `ctx_execute` con JavaScript para generar en memoria un log simulado de 10.000 líneas de compilación. Inserta `ERROR TS2322: Type 'string' is not assignable to type 'number'` en la línea 7000. Emite el log como salida de `ctx_execute` para localizar el primer error de compilación. Muéstrame el error y una línea antes y después. Luego llama a `ctx_stats` y muestra el informe. No crees archivos.

**Resultado verificado**.

- Recuperó el error `TS2322` en la línea 7000 y las líneas 6999 y 7001.
- La sesión completa, con 10 llamadas, produjo 363.194 bytes. Llegaron al modelo 13.385 bytes y quedaron fuera 349.809 bytes (96,3 %).
- El informe registró 1 fuente indexada, 88 fragmentos y 2 búsquedas.

El 96,3 % se refiere a los bytes de esta sesión con un log simulado. Cualquier equivalencia en tokens es una estimación del plugin. Puedes consultar el informe con `$ctx-stats` en el mismo chat.

Si al terminar la instalación aparece `hook-seen: not seen yet`, haz una llamada real desde Codex y vuelve a comprobar ese indicador.

#### Convivencia con RTK

Pide al agente que ejecute `git status --short --branch` en un repositorio Git. Si devuelve su estado, Git funcionó. Para confirmar también RTK, comprueba en la actividad que el hook reescribió la llamada como `rtk git status --short --branch`.

**Última prueba**. Vimos el estado del repositorio. La reescritura por RTK quedó pendiente de confirmar.

## Caveman sin hooks (opcional)

Caveman ofrece una skill para obtener respuestas más breves. En **PowerShell normal**, ejecuta este comando para instalar las skills de Caveman para tu usuario de Codex. La opción `--no-hooks` omite la instalación del hook de inicio de sesión.

```powershell
npx -y github:JuliusBrussee/caveman -- --only codex --no-hooks
```

Abre un chat nuevo de Codex en VS Code e invoca `$caveman` para activarlo en ese chat. Para volver al estilo habitual, escribe `stop caveman`.

## Fuentes oficiales

- [Guía oficial de instalación de Caveman](https://github.com/JuliusBrussee/caveman/blob/main/INSTALL.md)
- [Última versión estable de RTK](https://github.com/rtk-ai/rtk/releases/latest)
- [Agentes compatibles con RTK](https://github.com/rtk-ai/rtk/blob/develop/docs/guide/getting-started/supported-agents.md)
- [Requisitos e instalación de Context Mode v2](https://github.com/mksglu/context-mode/blob/main/docs/install/README.md)
- [Instalación y confianza de los hooks de Context Mode en Codex](https://github.com/mksglu/context-mode/blob/main/docs/install/codex.md)

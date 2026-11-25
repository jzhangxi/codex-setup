# Instalación en Windows

Antes de empezar, clona el repositorio y comprueba que tienes la app de Codex para Windows, la extensión Codex en VS Code y Node.js con `npx`. El instalador de RTK usa el ZIP oficial para Windows x64.

## 1. Integra las instrucciones globales en la app de Codex para Windows

Abre **Personalization → Codex instructions**. Añade el contenido de [AGENTS.global.md](../AGENTS.global.md) a las instrucciones globales del usuario y conserva el texto que ya exista.

## 2. Instala las skills en PowerShell normal

Usa PowerShell normal con tu cuenta habitual. Los comandos instalan las skills globalmente para Codex.

### Poner a prueba planes y decisiones

`grill-me` inicia una entrevista para aclarar un plan o una decisión. Se instala junto a `grilling`, que ordena las preguntas según las decisiones que deben resolverse primero.

```powershell
npx skills@latest add mattpocock/skills --skill grill-me grilling -a codex -g
```

### Buscar otras skills

`find-skills` ayuda a localizar skills para una tarea. Si el instalador la ofrece al instalar `grill-me`, acepta la oferta. Si todavía no está instalada y el aviso no aparece, usa el comando directo.

```powershell
npx skills@latest add vercel-labs/skills --skill find-skills -a codex -g
```

### Diagnosticar fallos y documentar decisiones de diseño

- `diagnosing-bugs` guía la reproducción de fallos y regresiones, la búsqueda de su causa y la comprobación de la corrección.
- `grill-with-docs` usa `grilling` y `domain-modeling` para poner a prueba un diseño y documentar el vocabulario y las decisiones que surjan.
- `domain-modeling` ayuda a definir los términos del dominio y mantener el glosario y los registros de decisiones de arquitectura.

```powershell
npx skills@latest add mattpocock/skills --skill=diagnosing-bugs --skill=grill-with-docs --skill=domain-modeling -a codex -g
```

### Revisar cambios de código

`code-review-and-quality` revisa la corrección, legibilidad, arquitectura, seguridad y rendimiento de un cambio antes de integrarlo.

```powershell
npx skills@latest add addyosmani/agent-skills --skill=code-review-and-quality -a codex -g
```

### Mantener los cambios de código sencillos

`ponytail` busca el cambio más pequeño que resuelva por completo la tarea y evita añadir código o abstracciones innecesarias.

```powershell
npx skills@latest add DietrichGebert/ponytail --skill=ponytail -a codex -g
```

### Comprobar las skills instaladas

Comprueba que las ocho skills aparecen en el listado global de Codex con sus orígenes.

```powershell
npx skills@latest list -g -a codex
```

**Lo que observamos.** El listado inicial mostró `grill-me`, `grilling` y `find-skills` con sus orígenes. Probamos `$grill-me` en Codex de VS Code y funcionó. De `find-skills` solo comprobamos su presencia en el listado.

### Caveman sin hooks (opcional)

Caveman ofrece una skill para obtener respuestas más breves. En **PowerShell normal**, ejecuta este comando para instalar las skills de Caveman solo para Codex. La opción `--no-hooks` omite la instalación del hook de inicio de sesión.

```powershell
npx -y github:JuliusBrussee/caveman -- --only codex --no-hooks
```

Abre un chat nuevo de Codex en VS Code e invoca `$caveman` para activarlo en ese chat. Para volver al estilo habitual, escribe `stop caveman`.

## 3. Instala RTK en PowerShell como administrador

Abre **PowerShell como administrador**, sitúate en la raíz del repositorio clonado y ejecuta el [instalador de RTK](install-rtk.ps1).

```powershell
.\windows\install-rtk.ps1
```

El script descarga el ZIP oficial, comprueba la versión del ejecutable extraído, lo copia a `C:\Program Files\RTK\` y añade esa carpeta al `Path` del sistema si hace falta.

Si ya existe `rtk.exe` en el destino, el script se detiene. Para reemplazar esa copia, renómbrala como respaldo antes de volver a ejecutar el instalador.

**Lo que observamos.** La primera ejecución sin permisos de administrador falló al crear la carpeta de RTK.

## 4. Registra el hook en PowerShell normal

Vuelve a **PowerShell normal** con tu cuenta habitual. Comprueba la versión por ruta absoluta y registra el hook global de Codex para esa cuenta.

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
& 'C:\Program Files\RTK\rtk.exe' init -g --codex
```

## 5. Habilita y verifica el hook en VS Code

1. Cierra todas las ventanas de VS Code y vuelve a abrirlo.
2. Habilita el hook `PreToolUse` de RTK si está pendiente. En la interfaz de Codex que usamos apareció en **User config → All projects**.
3. Abre un chat nuevo de Codex en un repositorio Git y sigue las [comprobaciones de diagnóstico](diagnostico.md).

## Plugins opcionales

### Context7

Context7 incluye herramientas MCP para recuperar documentación y una skill que puede consultarla cuando la tarea lo requiera.

En **PowerShell normal**, con tu cuenta habitual, ejecuta estos comandos en orden.

```powershell
codex plugin marketplace add upstash/context7
codex plugin add context7@context7-marketplace
```

Cuando se abra el navegador, completa el inicio de sesión en Context7. Después, inicia un chat nuevo de Codex en VS Code y sigue la [prueba de Context7](diagnostico.md#context7).

### Superpowers

Superpowers aporta skills para diseñar, planificar, implementar y verificar cambios. Elige una de estas dos vías de instalación.

- **App de Codex para Windows**. Abre **Plugins**, busca **Superpowers** y pulsa **+**.
- **Codex CLI**. Ejecuta `codex` en PowerShell. Dentro de la sesión de Codex, escribe `/plugins`, busca **Superpowers** y elige **Install Plugin**.

Con una vía basta. Después, abre un chat nuevo de Codex en VS Code y sigue las [pruebas de Superpowers](diagnostico.md#superpowers).

### Context Mode v2

Context Mode es opcional. Permite indexar salidas grandes de herramientas y recuperar solo los fragmentos necesarios para la tarea.

#### Requisitos y cambio de Node con NVM para Windows

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

#### Instalación y confianza de los hooks

Ejecuta estos comandos en **PowerShell normal**.

```powershell
codex plugin marketplace add mksglu/context-mode
codex plugin add context-mode@context-mode
npm install -g context-mode
context-mode setup --agents codex
context-mode doctor
```

Si `doctor` muestra `4 of 4 context-mode plugin hooks untrusted` y pregunta **Fix codex now?**, selecciona **Yes** para que ejecute `context-mode setup --agents codex`. Después, vuelve a ejecutar `context-mode doctor`. En nuestro caso, la fila `codex` pasó de `FAIL` a `PASS` tras el arreglo.

Cierra y vuelve a abrir VS Code. Abre un chat nuevo de Codex y sigue la [prueba de Context Mode](diagnostico.md#context-mode-v2). Usa `context-mode doctor` para verificar la instalación o diagnosticar fallos. Puedes omitirlo al iniciar una sesión normal.

## Angular y .NET 10 en el CMS

La skill de Angular se instala en el proyecto CMS. Los plugins de .NET se instalan por usuario en Codex.

### Instalar la skill de Angular en el CMS

Abre **PowerShell normal** en la raíz del CMS y ejecuta este comando.

```powershell
npx skills@latest add angular/skills --skill=angular-developer -a codex
```

Omite `-g` para instalar la skill en el proyecto. Si el instalador ofrece varios métodos de instalación, elige **Copy** para llevar los archivos a TFS como archivos normales.

### Instalar los plugins de .NET en Codex

Ejecuta en **PowerShell normal** con tu cuenta habitual.

```powershell
codex plugin marketplace add dotnet/skills
codex
```

Dentro de Codex, abre `/plugins` y entra en `dotnet-agent-skills`. Instala `dotnet` para C# y compilación, y `dotnet-data` para EF Core y acceso a datos.

### Compartir la configuración del CMS en TFS

- Incluye `.agents/skills/angular-developer/` completa, con `SKILL.md` y los archivos de apoyo. Comprueba que sean archivos reales y que la carpeta no sea un enlace a tu perfil de usuario.
- Incluye `skills-lock.json` si el instalador lo generó para el proyecto.
- Añade `AGENTS.md` cuando estén listas las convenciones del CMS.
- Añade `README.md` si has documentado cómo instalar `dotnet` y `dotnet-data` para tus compañeros.

Si por ahora solo has instalado la skill de Angular, sube su carpeta y `skills-lock.json` si existe. Cada persona instala los plugins de .NET en su cuenta de Codex.

## Fuentes oficiales

- [CLI de skills de Vercel](https://github.com/vercel-labs/skills)
- [Ficha de find-skills](https://skills.sh/vercel-labs/skills/find-skills)
- [Repositorio de skills de Matt Pocock](https://github.com/mattpocock/skills)
- [Skill de revisión de código de Addy Osmani](https://github.com/addyosmani/agent-skills/tree/main/skills/code-review-and-quality)
- [Repositorio de Ponytail](https://github.com/DietrichGebert/ponytail)
- [Guía oficial de instalación de Caveman](https://github.com/JuliusBrussee/caveman/blob/main/INSTALL.md)
- [Última versión estable de RTK](https://github.com/rtk-ai/rtk/releases/latest)
- [Agentes compatibles con RTK](https://github.com/rtk-ai/rtk/blob/develop/docs/guide/getting-started/supported-agents.md)
- [Instalación de Context7 en Codex](https://github.com/upstash/context7/blob/master/docs/clients/codex.mdx)
- [Superpowers en el catálogo de plugins de Codex](https://github.com/openai/plugins/blob/main/plugins/superpowers/README.md)
- [Requisitos e instalación de Context Mode v2](https://github.com/mksglu/context-mode/blob/main/docs/install/README.md)
- [Instalación y confianza de los hooks de Context Mode en Codex](https://github.com/mksglu/context-mode/blob/main/docs/install/codex.md)
- [Skills oficiales de Angular](https://github.com/angular/angular/blob/main/adev/src/content/ai/agent-skills.md)
- [Skills y plugins oficiales de .NET](https://github.com/dotnet/skills/)

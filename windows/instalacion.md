# Instalación en Windows

Sigue estos pasos en Windows nativo. Ten a mano el repositorio clonado, la extensión Codex en VS Code y Node.js con `npx`. El instalador de RTK utiliza el ZIP oficial para Windows x64.

## 1. Integra las instrucciones globales de Codex

En la **app de Codex para Windows**, abre **Personalization → Codex instructions**. Añade el contenido de [AGENTS.global.md](../AGENTS.global.md) a las instrucciones globales del usuario y conserva el texto que ya exista.

## 2. Instala las skills en PowerShell normal

Usa PowerShell normal con tu cuenta habitual. Los comandos instalan las skills globalmente para Codex.

### Poner a prueba planes y decisiones

`grill-me` abre una entrevista para aclarar un plan o una decisión. Usa `grilling` para organizar las preguntas y resolver las decisiones en el orden en que dependen unas de otras. Por eso se instalan juntas.

```powershell
npx skills@latest add mattpocock/skills --skill grill-me grilling -a codex -g
```

### Buscar otras skills

`find-skills` ayuda a localizar skills para una tarea. Si el instalador la ofrece al instalar `grill-me`, responde que sí. Este es el comando directo para instalarla por separado si no aparece el aviso. Si ya la aceptaste, puedes omitirlo.

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

### Verificar las instalaciones

Comprueba que las ocho skills aparecen en el listado global de Codex con sus orígenes.

```powershell
npx skills@latest list -g -a codex
```

En la instalación inicial, el listado confirmó `grill-me`, `grilling` y `find-skills` con sus orígenes. Probamos `$grill-me` en Codex de VS Code y funcionó. De `find-skills` solo confirmamos su presencia en el listado.

## 3. Instala RTK en PowerShell como administrador

Abre **PowerShell como administrador**, sitúate en la raíz del repositorio clonado y ejecuta el [instalador de RTK](install-rtk.ps1).

```powershell
.\windows\install-rtk.ps1
```

El script descarga el ZIP oficial, comprueba la versión del ejecutable extraído, lo copia a `C:\Program Files\RTK\` y añade esa carpeta al `Path` del sistema si hace falta. La primera ejecución que hicimos sin elevación falló al crear esa carpeta. Si ya existe `rtk.exe` en el destino, el script se detiene. Si quieres reemplazar esa copia, renómbrala como respaldo antes de volver a ejecutar el instalador.

## 4. Registra el hook en PowerShell normal

Vuelve a **PowerShell normal** con tu cuenta habitual. Comprueba la versión por ruta absoluta y registra el hook global de Codex para esa cuenta.

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
& 'C:\Program Files\RTK\rtk.exe' init -g --codex
```

## 5. Habilita y verifica el hook en VS Code

Cierra todas las ventanas de **VS Code** y vuelve a abrirlo. En la interfaz de Codex que usamos, el hook `PreToolUse` de RTK apareció en **User config → All projects**. Habilítalo si está pendiente.

Abre un chat nuevo de Codex en un repositorio Git y sigue las [comprobaciones de diagnóstico](diagnostico.md). Si el agente sigue heredando un `Path` anterior, cierra sesión en Windows, vuelve a iniciarla y repite las comprobaciones desde un chat nuevo.

## Fuentes oficiales

- [CLI de skills de Vercel](https://github.com/vercel-labs/skills)
- [Ficha de find-skills](https://skills.sh/vercel-labs/skills/find-skills)
- [Repositorio de skills de Matt Pocock](https://github.com/mattpocock/skills)
- [Skill de revisión de código de Addy Osmani](https://github.com/addyosmani/agent-skills/tree/main/skills/code-review-and-quality)
- [Repositorio de Ponytail](https://github.com/DietrichGebert/ponytail)
- [Última versión estable de RTK](https://github.com/rtk-ai/rtk/releases/latest)
- [Agentes compatibles con RTK](https://github.com/rtk-ai/rtk/blob/develop/docs/guide/getting-started/supported-agents.md)

# Desarrollo frontend

Instala estas skills desde **PowerShell normal**, con tu cuenta habitual. Los comandos se aplican al usuario de Codex.

## Maquetar y revisar interfaces web

- [frontend-design de Anthropic](https://github.com/anthropics/skills/tree/main/skills/frontend-design) guía el diseño y la implementación de páginas y componentes web, con atención a la composición, la tipografía y el estilo visual.
- [web-design-guidelines de Vercel](https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines) revisa interfaces web según las pautas de Vercel sobre diseño, accesibilidad y experiencia de usuario.

```powershell
npx skills@latest add anthropics/skills --skill=frontend-design -a codex -g
npx skills@latest add vercel-labs/agent-skills --skill=web-design-guidelines -a codex -g
```

Comprueba las skills en el [listado global de Codex](general.md#comprobar-las-skills-instaladas).

## Angular en el CMS

Abre **PowerShell normal** en la raíz del CMS y ejecuta este comando.

```powershell
npx skills@latest add angular/skills --skill=angular-developer -a codex
```

Omite `-g` para instalar la skill en el proyecto. Si el instalador ofrece varios métodos, elige **Copy** para compartir archivos normales en TFS.

### Compartir en TFS

- Incluye `.agents/skills/angular-developer/` completa, con `SKILL.md` y los archivos de apoyo. Comprueba que sean archivos reales y que la carpeta no sea un enlace a tu perfil.
- Incluye `skills-lock.json` si el instalador lo generó para el proyecto.
- Añade `AGENTS.md` cuando estén listas las convenciones del CMS.
- Añade `README.md` si documentas los pasos de instalación para tus compañeros.

Si por ahora solo has instalado la skill de Angular, sube su carpeta y `skills-lock.json` si existe.

[Fuente oficial de skills de Angular](https://github.com/angular/angular/blob/main/adev/src/content/ai/agent-skills.md)

### Verificar la skill de Angular

En un chat nuevo de Codex en VS Code abierto en el CMS, comprueba que `angular-developer` aparece en el selector de skills. Para consultar la documentación de la versión de Angular del proyecto, usa la [prueba de Context7](documentacion-tecnica.md#verificar-context7).

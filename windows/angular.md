# Skill de Angular para el CMS

Abre **PowerShell normal** en la raíz del CMS y ejecuta este comando.

```powershell
npx skills@latest add angular/skills --skill=angular-developer -a codex
```

Omite `-g` para instalar la skill en el proyecto. Si el instalador ofrece varios métodos, elige **Copy** para compartir archivos normales en TFS.

## Compartir en TFS

- Incluye `.agents/skills/angular-developer/` completa, con `SKILL.md` y los archivos de apoyo. Comprueba que sean archivos reales y que la carpeta no sea un enlace a tu perfil.
- Incluye `skills-lock.json` si el instalador lo generó para el proyecto.
- Añade `AGENTS.md` cuando estén listas las convenciones del CMS.
- Añade `README.md` si documentas los pasos de instalación para tus compañeros.

Si por ahora solo has instalado la skill de Angular, sube su carpeta y `skills-lock.json` si existe.

[Fuente oficial de skills de Angular](https://github.com/angular/angular/blob/main/adev/src/content/ai/agent-skills.md)

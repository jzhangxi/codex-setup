# Calidad y mantenimiento

Instala estas skills desde **PowerShell normal**, con tu cuenta habitual. Los comandos se aplican al usuario de Codex.

## Revisar cambios de código

`code-review-and-quality` revisa la corrección, legibilidad, arquitectura, seguridad y rendimiento de un cambio antes de integrarlo.

```powershell
npx skills@latest add addyosmani/agent-skills --skill=code-review-and-quality -a codex -g
```

## Diagnosticar fallos

`diagnosing-bugs` guía la reproducción de fallos y regresiones, la búsqueda de su causa y la comprobación de la corrección. Se instala con el [comando compartido de Matt Pocock](arquitectura.md#documentar-decisiones-de-diseño).

## Mantener los cambios de código sencillos

`ponytail` busca el cambio más pequeño que resuelva por completo la tarea y evita añadir código o abstracciones innecesarias.

```powershell
npx skills@latest add DietrichGebert/ponytail --skill=ponytail -a codex -g
```

Comprueba las skills en el [listado global de Codex](general.md#comprobar-las-skills-instaladas).

## Fuentes oficiales

- [Skill de revisión de código de Addy Osmani](https://github.com/addyosmani/agent-skills/tree/main/skills/code-review-and-quality)
- [Repositorio de Ponytail](https://github.com/DietrichGebert/ponytail)

# Configuración general de Codex en Windows

## Requisitos comunes

[Clona el repositorio](../README.md#clonar-el-repositorio) desde PowerShell con Git instalado. Comprueba que tienes la app de Codex para Windows, la extensión Codex en VS Code y Node.js con `npx`.

## Integra las instrucciones globales en la app de Codex para Windows

Abre **Personalization → Codex instructions**. Añade el contenido de [AGENTS.global.md](../AGENTS.global.md) a las instrucciones globales del usuario y conserva el texto que ya exista.

## Buscar otras skills

`find-skills` ayuda a localizar skills para una tarea. Si el instalador la ofrece al instalar `grill-me`, acepta la oferta. Si todavía no está instalada y el aviso no aparece, usa el comando directo.

```powershell
npx skills@latest add vercel-labs/skills --skill find-skills -a codex -g
```

## Comprobar las skills instaladas

En **PowerShell normal**, comprueba que las skills que elegiste aparecen en el listado global de Codex con sus orígenes.

```powershell
npx skills@latest list -g -a codex
```

**Lo que observamos.** El listado inicial mostró `grill-me`, `grilling` y `find-skills` con sus orígenes. Probamos `$grill-me` en Codex de VS Code y funcionó. De `find-skills` solo comprobamos su presencia en el listado.

## Skills de Matt Pocock pendientes de investigar

- `handoff`. Probar si su resumen permite retomar una tarea en otro chat de Codex con las decisiones, los archivos y los pasos pendientes. [Ficha de handoff](https://skills.sh/mattpocock/skills/handoff)
- `retro`. Probar si una retrospectiva de una sesión difícil detecta mejoras concretas en las instrucciones, las comprobaciones o el uso de herramientas. Usa [`writing-for-agents`](https://skills.sh/mattpocock/skills/writing-for-agents). [Ficha de retro](https://skills.sh/mattpocock/skills/retro)
- `to-tickets`. Probar si divide un plan del CMS en tareas verificables y ordenadas por dependencias. Empezar con archivos locales y configurar el repositorio con [`setup-matt-pocock-skills`](https://skills.sh/mattpocock/skills/setup-matt-pocock-skills). [Ficha de to-tickets](https://skills.sh/mattpocock/skills/to-tickets)

## Fuentes oficiales

- [CLI de skills de Vercel](https://github.com/vercel-labs/skills)
- [Ficha de find-skills](https://skills.sh/vercel-labs/skills/find-skills)

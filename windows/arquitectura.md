# Arquitectura y planificación

## Superpowers

Superpowers aporta skills para diseñar, planificar, implementar y verificar cambios. Elige una de estas dos vías de instalación para tu usuario de Codex.

- **App de Codex para Windows**. Abre **Plugins**, busca **Superpowers** y pulsa **+**.
- **Codex CLI**. Ejecuta `codex` en PowerShell. Dentro de la sesión de Codex, escribe `/plugins`, busca **Superpowers** y elige **Install Plugin**.

Con una vía basta. Después, abre un chat nuevo de Codex en VS Code y sigue las [pruebas de Superpowers](#verificar-superpowers).

### Verificar Superpowers

La confirmación en Codex de VS Code queda pendiente. Realiza las comprobaciones por separado.

#### Activación automática

Abre un chat nuevo en el repositorio `codex-setup` y envía esta petición sin mencionar Superpowers.

> Quiero una guía rápida para comprobar `codex-setup` en un PC nuevo. Revisa el README y las guías de Windows. Ayúdame a decidir si conviene añadir la lista de comprobación al README o a la guía de configuración general. Antes de editar, explícame las opciones, recomiéndame una y espera mi decisión.

Busca en la actividad del chat que se haya cargado una skill de Superpowers, por ejemplo `brainstorming`. Una pregunta o un plan también podrían venir del `AGENTS.md` global. Si la actividad no muestra la carga, deja la activación automática como pendiente de confirmar.

#### Activación explícita

Si la activación automática queda sin confirmar, abre otro chat en `codex-setup`. Busca `brainstorming` en el selector de skills, selecciónala y repite la petición. Comprueba en la actividad que se haya cargado la skill de Superpowers y registra este resultado por separado.

## Poner a prueba planes y decisiones

`grill-me` inicia una entrevista para aclarar un plan o una decisión. Se instala junto a `grilling`, que ordena las preguntas según las decisiones que deben resolverse primero.

Instala estas skills desde **PowerShell normal**, con tu cuenta habitual. Los comandos se aplican al usuario de Codex.

```powershell
npx skills@latest add mattpocock/skills --skill grill-me grilling -a codex -g
```

## Documentar decisiones de diseño

- `grill-with-docs` usa `grilling` y `domain-modeling` para poner a prueba un diseño y documentar el vocabulario y las decisiones que surjan.
- `domain-modeling` ayuda a definir los términos del dominio y mantener el glosario y los registros de decisiones de arquitectura.

Este comando también instala [`diagnosing-bugs`](calidad.md#diagnosticar-fallos). Ejecútalo una vez desde **PowerShell normal** con tu cuenta habitual.

```powershell
npx skills@latest add mattpocock/skills --skill=diagnosing-bugs --skill=grill-with-docs --skill=domain-modeling -a codex -g
```

Comprueba las skills en el [listado global de Codex](general.md#comprobar-las-skills-instaladas).

## Fuentes oficiales

- [Repositorio de skills de Matt Pocock](https://github.com/mattpocock/skills)
- [Superpowers en el catálogo de plugins de Codex](https://github.com/openai/plugins/blob/main/plugins/superpowers/README.md)

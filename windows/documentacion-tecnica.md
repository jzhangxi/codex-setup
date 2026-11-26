# Documentación técnica

## Context7

Context7 incluye herramientas MCP para recuperar documentación y una skill que puede consultarla cuando la tarea lo requiera.

En **PowerShell normal**, con tu cuenta habitual, ejecuta estos comandos de Codex CLI para instalar el plugin por usuario.

```powershell
codex plugin marketplace add upstash/context7
codex plugin add context7@context7-marketplace
```

Cuando se abra el navegador, completa el inicio de sesión en Context7. Después, inicia un chat nuevo de Codex en VS Code y sigue la [prueba de Context7](#verificar-context7).

### Verificar Context7

La confirmación en Codex de VS Code queda pendiente.

Después de instalar Context7, abre un chat nuevo en un proyecto Angular cuyo `package.json` declare `@angular/core`. Envía esta petición.

> Lee `package.json` para identificar la versión de `@angular/core`. Usa Context7 para consultar cómo declarar un input obligatorio con `input.required()` en esa versión. Dame un ejemplo mínimo e indica qué documentación y versión recuperaste. Si Context7 devuelve documentación general o de otra versión, indícalo. No modifiques archivos.

- **Integración MCP**. Queda verificada si en la actividad del chat aparecen llamadas a Context7, como `resolve-library-id` y `query-docs`.
- **Versión de la documentación**. Registra por separado si corresponde a la que pide el proyecto, si es documentación general o si corresponde a otra versión.

## Fuentes oficiales

- [Instalación de Context7 en Codex](https://github.com/upstash/context7/blob/master/docs/clients/codex.mdx)

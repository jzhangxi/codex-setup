# Exploración de código con GitNexus

GitNexus indexa el código de un repositorio Git. Úsalo para encontrar quién llama a una función, seguir un flujo o ver qué otras partes del código podrían verse afectadas por un cambio.

## Instalar la CLI en Windows

Abre **PowerShell normal**. Necesitas Git y Node.js **22.18 o posterior de la rama 22.x**, o **24.11 o posterior**. Si ya usas Node.js 24.15.0 para [Context Mode](ahorro-contexto.md#context-mode-v2), puedes usar esa misma versión.

```powershell
node --version
git --version
npm install -g gitnexus
gitnexus --version
```

El paquete se instala en el entorno global de npm del Node activo. Si cambias de versión con NVM y `gitnexus` deja de estar disponible, vuelve a la versión anterior o instala el paquete en la nueva.

## Indexar y comprobar un repositorio

En **PowerShell normal**, abre la raíz de un repositorio Git de prueba que contenga código y ejecuta:

```powershell
gitnexus analyze --index-only
gitnexus status
```

`--index-only` crea el índice local sin añadir las instrucciones ni las skills de integración al repositorio. Comprueba que `status` reconoce el índice. Sustituye `NombreDeFuncion` por una función que sepas que tiene al menos un llamador:

```powershell
gitnexus context NombreDeFuncion
gitnexus impact NombreDeFuncion --direction upstream
```

Contrasta al menos un llamador con el código. Si hay varios símbolos con el mismo nombre, añade `--file` con la ruta del archivo. Cuando cambie el código, vuelve a ejecutar `gitnexus analyze --index-only` para actualizar el índice. Si falla la búsqueda de texto completo en Windows, consulta los requisitos de Visual C++ y OpenSSL en la [guía de diagnóstico de GitNexus](https://github.com/abhigyanpatwari/GitNexus/blob/main/gitnexus/README.md#windows-full-text-search-unavailable).

## Conectar GitNexus a Codex

Desde **PowerShell normal**, registra el servidor MCP por usuario. En Windows, `cmd.exe` ejecuta el archivo `gitnexus.cmd` de la instalación global de npm.

```powershell
codex mcp add gitnexus -- cmd.exe /c gitnexus.cmd mcp
codex mcp list
```

Comprueba que `gitnexus` figura en el listado. Abre un chat nuevo de Codex en VS Code en el repositorio indexado. Pide que use GitNexus para identificar quién llama a la misma función y que cite el archivo del llamador. La integración queda verificada cuando la actividad del chat muestra una llamada al MCP de GitNexus y el resultado coincide con la comprobación en la CLI.

La conexión MCP manual es la vía principal de esta guía. Si necesitas las skills y los hooks de GitNexus, usa la vía del **plugin oficial** de la [guía de integración](https://github.com/abhigyanpatwari/GitNexus/blob/main/docs/editor-setup.md). Sustituye el registro MCP manual al cambiar de vía y comprueba los hooks de GitNexus junto con [RTK y Context Mode](ahorro-contexto.md) antes de darlos por validados.

## Fuentes oficiales

- [Requisitos y comandos de GitNexus](https://github.com/abhigyanpatwari/GitNexus/blob/main/gitnexus/README.md)
- [Integración de GitNexus con Codex](https://github.com/abhigyanpatwari/GitNexus/blob/main/docs/editor-setup.md)

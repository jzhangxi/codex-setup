# codex-setup

Este repositorio documenta la instalación manual y reproducible de mi configuración global de Codex en Windows nativo. La verificación se centra en Codex de VS Code.

## Clonar el repositorio

Clona el repositorio desde PowerShell con Git instalado.

```powershell
git clone https://github.com/jzhangxi/codex-setup.git
cd codex-setup
```

## Configurar un PC nuevo

1. Aplica la [configuración general](windows/general.md) en la app de Codex y comprueba los requisitos comunes.
2. [Instala y verifica RTK](windows/ahorro-contexto.md#rtk) en ese PC.
3. Elige los recursos que necesites en el índice. Cada guía indica el método y el ámbito de instalación y cómo comprobar el resultado en VS Code.

## Guías por dominio

- [Configuración general](windows/general.md)
- [Arquitectura y planificación](windows/arquitectura.md)
- [Desarrollo frontend y Angular](windows/frontend.md)
- [.NET 10](windows/dotnet.md)
- [Documentación técnica con Context7](windows/documentacion-tecnica.md)
- [Calidad y mantenimiento](windows/calidad.md)
- [Ahorro de contexto y respuestas](windows/ahorro-contexto.md)

## Versiones y archivos locales


El repositorio guarda las instrucciones, los comandos y el script. Los binarios, las credenciales, el historial y la configuración local generada, como `hooks.json`, quedan fuera del repositorio.

`skills@latest` y la última versión estable de RTK pueden cambiar. Puedes repetir el procedimiento aunque las versiones instaladas varíen.

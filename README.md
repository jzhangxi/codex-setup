# codex-setup

Este repositorio documenta la instalación manual y reproducible de mi configuración global de Codex en Windows nativo. La verificación se centra en Codex de VS Code.

## Clonar el repositorio

Clona el repositorio desde PowerShell con Git instalado.

```powershell
git clone https://github.com/jzhangxi/codex-setup.git
cd codex-setup
```

## Instalar y verificar

1. Sigue la [guía de instalación en Windows](windows/instalacion.md) para configurar las instrucciones globales, las skills y RTK.
2. Realiza las [comprobaciones de RTK en VS Code](windows/diagnostico.md) en cada PC.

La guía incluye [dos plugins opcionales](windows/instalacion.md#plugins-opcionales). Context7 consulta documentación técnica y Superpowers aporta skills para trabajar en cambios de software.

## Versiones y archivos locales

El repositorio guarda las instrucciones, los comandos y el script. Los binarios, las credenciales, el historial y la configuración local generada, como `hooks.json`, quedan fuera del repositorio.

`skills@latest` y la última versión estable de RTK pueden cambiar. Puedes repetir el procedimiento aunque las versiones instaladas varíen.

# Diagnóstico de RTK en Codex de VS Code

Haz la verificación completa en cada PC, después de seguir la [guía de instalación](instalacion.md).

## Lo que observamos

- La copia de RTK en `AppData\Local\Programs\RTK` funcionaba en PowerShell normal. El sandbox de Codex en VS Code no pudo ejecutarla por ruta absoluta.
- El sandbox sí pudo ejecutar la copia en `C:\Program Files\RTK\rtk.exe` por ruta absoluta.
- El hook llegó a reescribir `git status` como `rtk git status`. El comando reescrito falló porque la terminal aislada no resolvía `rtk` por nombre.

## Tres comprobaciones en el chat de Codex

Abre un chat nuevo de Codex en VS Code en un repositorio Git. Pídele al agente que ejecute estos comandos **por separado**, en este orden.

```powershell
& 'C:\Program Files\RTK\rtk.exe' --version
(Get-Command rtk -CommandType Application -ErrorAction Stop).Source
git status --short --branch
```

1. La primera comprobación debe mostrar la versión de RTK desde el sandbox.
2. La segunda comprueba el `Path` efectivo del agente. Debe devolver `C:\Program Files\RTK\rtk.exe`.
3. La última prueba el hook de principio a fin. Pide `git status --short --branch` tal como está escrito, sin prefijo. La prueba se cumple cuando el hook reescribe el comando y este devuelve el estado del repositorio.

Si quieres consultar estadísticas, ejecuta `rtk gain` en PowerShell normal. Es opcional.

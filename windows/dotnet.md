# Plugins de .NET 10 para Codex

Cada persona instala estos plugins en su cuenta de Codex. En **PowerShell normal**, registra el catálogo e instala los cinco plugins.

```powershell
codex plugin marketplace add dotnet/skills
codex plugin add dotnet-aspnetcore@dotnet-agent-skills
codex plugin add dotnet-data@dotnet-agent-skills
codex plugin add dotnet-test@dotnet-agent-skills
codex plugin add dotnet-diag@dotnet-agent-skills
codex plugin add dotnet-nuget@dotnet-agent-skills
```

- `dotnet-aspnetcore` aporta skills para aplicaciones web y API.
- `dotnet-data` cubre EF Core y acceso a datos.
- `dotnet-test` ayuda con pruebas de .NET.
- `dotnet-diag` ayuda a diagnosticar fallos y rendimiento.
- `dotnet-nuget` cubre la gestión de paquetes y dependencias.

Abre un chat nuevo de Codex en VS Code para cargar los plugins. Puedes añadir los pasos al `README.md` del CMS y compartirlo en TFS con tus compañeros.

[Fuente oficial de skills y plugins de .NET](https://github.com/dotnet/skills/)

$ErrorActionPreference = 'Stop'

$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
try {
    $principal = [Security.Principal.WindowsPrincipal]::new($identity)
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        throw 'Abre PowerShell como administrador y vuelve a ejecutar el instalador.'
    }
} finally {
    $identity.Dispose()
}

$rtkDir = 'C:\Program Files\RTK'
$rtkExe = Join-Path $rtkDir 'rtk.exe'
if (Test-Path -LiteralPath $rtkExe) {
    throw "Ya existe $rtkExe. Si quieres reemplazarlo, renómbralo como respaldo y vuelve a ejecutar el instalador."
}

$tempRoot = (Resolve-Path -LiteralPath $env:TEMP).ProviderPath
$rtkTemp = Join-Path $tempRoot ('rtk-install-' + [guid]::NewGuid())

$release = Invoke-RestMethod 'https://api.github.com/repos/rtk-ai/rtk/releases/latest'
$asset = $release.assets |
    Where-Object name -eq 'rtk-x86_64-pc-windows-msvc.zip' |
    Select-Object -First 1

if (-not $asset) {
    throw "No se encontró el ZIP oficial de Windows x64 en $($release.tag_name)."
}

New-Item -ItemType Directory -Path $rtkTemp | Out-Null

try {
    $zip = Join-Path $rtkTemp $asset.name
    Invoke-WebRequest -UseBasicParsing -Uri $asset.browser_download_url -OutFile $zip
    Expand-Archive -LiteralPath $zip -DestinationPath (Join-Path $rtkTemp 'expanded')

    $exe = Get-ChildItem (Join-Path $rtkTemp 'expanded') -Filter 'rtk.exe' -File -Recurse |
        Select-Object -First 1
    if (-not $exe) { throw 'El ZIP no contiene rtk.exe.' }

    & $exe.FullName --version
    if ($LASTEXITCODE -ne 0) { throw 'Falló la comprobación de la versión del ejecutable extraído.' }

    New-Item -ItemType Directory -Path $rtkDir -Force | Out-Null
    [IO.File]::Copy($exe.FullName, $rtkExe, $false)

    # Conserva el tipo del valor y las referencias como %SystemRoot%.
    $environmentKey = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey(
        'SYSTEM\CurrentControlSet\Control\Session Manager\Environment', $true)
    try {
        $machinePath = $environmentKey.GetValue(
            'Path', $null, [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
        $pathKind = [Microsoft.Win32.RegistryValueKind]::ExpandString
        if ($null -ne $machinePath) {
            $pathKind = $environmentKey.GetValueKind('Path')
        }

        $pathForComparison = $machinePath
        if ($pathKind -eq [Microsoft.Win32.RegistryValueKind]::ExpandString) {
            $pathForComparison = [Environment]::ExpandEnvironmentVariables([string]$machinePath)
        }
        $pathFolders = ($pathForComparison -split ';') | ForEach-Object {
            $_.Trim().Trim('"').TrimEnd('\', '/').Replace('/', '\')
        }
        if ($rtkDir -notin $pathFolders) {
            $newPath = $rtkDir
            if ($machinePath) {
                $newPath = "$machinePath;$rtkDir"
            }
            $environmentKey.SetValue('Path', $newPath, $pathKind)
        }
    } finally {
        $environmentKey.Dispose()
    }
} finally {
    Remove-Item -LiteralPath $rtkTemp -Recurse -Force
}

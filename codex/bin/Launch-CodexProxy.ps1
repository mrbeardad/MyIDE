param(
    [string]$PackageFamilyName = 'OpenAI.Codex_2p2nqsd0c76g0',
    [string]$AppId = 'App',
    [string]$ProxyServer = 'http://127.0.0.1:7890',
    [switch]$ShowCommandLine,
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$package = Get-AppxPackage -Name 'OpenAI.Codex' | Where-Object {
    $_.PackageFamilyName -eq $PackageFamilyName
} | Select-Object -First 1

if (-not $package) {
    throw "Package family '$PackageFamilyName' was not found. Install Codex or update PackageFamilyName."
}

$aumid = "$PackageFamilyName!$AppId"
$launchArgs = "--proxy-server=$ProxyServer"

if ($ShowCommandLine) {
    Write-Host "Activating packaged app: $aumid"
    Write-Host "Arguments: $launchArgs"
}

if ($DryRun) {
    Write-Host "Dry run only. Codex was not launched."
    exit 0
}

if (-not ([System.Management.Automation.PSTypeName]'CodexLauncher.ApplicationActivation').Type) {
    Add-Type -TypeDefinition @'
using System;
using System.Runtime.InteropServices;

namespace CodexLauncher
{
    [ComImport]
    [Guid("2e941141-7f97-4756-ba1d-9decde894a3d")]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    internal interface IApplicationActivationManagerNative
    {
        [PreserveSig]
        int ActivateApplication(
            [MarshalAs(UnmanagedType.LPWStr)] string appUserModelId,
            [MarshalAs(UnmanagedType.LPWStr)] string arguments,
            uint options,
            out uint processId);

        [PreserveSig]
        int ActivateForFile(
            [MarshalAs(UnmanagedType.LPWStr)] string appUserModelId,
            IntPtr itemArray,
            [MarshalAs(UnmanagedType.LPWStr)] string verb,
            out uint processId);

        [PreserveSig]
        int ActivateForProtocol(
            [MarshalAs(UnmanagedType.LPWStr)] string appUserModelId,
            IntPtr itemArray,
            out uint processId);
    }

    [ComImport]
    [Guid("45BA127D-10A8-46EA-8AB7-56EA9078943C")]
    internal class ApplicationActivationManagerNative
    {
    }

    public static class ApplicationActivation
    {
        public static int ActivateApplication(string appUserModelId, string arguments, out uint processId)
        {
            IApplicationActivationManagerNative manager =
                (IApplicationActivationManagerNative)new ApplicationActivationManagerNative();

            return manager.ActivateApplication(appUserModelId, arguments, 0, out processId);
        }
    }
}
'@
}

[uint32]$processId = 0
$result = [CodexLauncher.ApplicationActivation]::ActivateApplication($aumid, $launchArgs, [ref]$processId)

if ($result -ne 0) {
    $hrUnsigned = [System.BitConverter]::ToUInt32([System.BitConverter]::GetBytes([int32]$result), 0)
    $hrHex = '0x{0:X8}' -f $hrUnsigned
    throw "ActivateApplication failed for '$aumid' with HRESULT $hrHex."
}

Write-Host "Launched Codex packaged app with PID $processId through proxy $ProxyServer."

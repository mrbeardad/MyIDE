Option Explicit
Dim shell, command
Set shell = CreateObject("WScript.Shell")
command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File ""C:\Users\beardad\.codex\bin\Launch-CodexProxy.ps1"""
shell.Run command, 0, False

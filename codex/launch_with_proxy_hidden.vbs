Dim shell
Dim command

Set shell = CreateObject("WScript.Shell")
command = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""C:\Users\beardad\.codex\launch_with_proxy.ps1"""
shell.Run command, 0, False

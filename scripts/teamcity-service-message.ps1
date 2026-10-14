# Write-Host is safe for TeamCity service messages.
# Write-Output can get line-wrapped by the console host and break
# multi-line service messages — avoid it for anything TeamCity needs to parse.
Write-Host "##teamcity[buildStatus text='PowerShell runner verification OK']"
Write-Host "##teamcity[progressMessage 'Custom progress message from script']"
Write-Host "##teamcity[message text='Custom build log message' status='NORMAL']"

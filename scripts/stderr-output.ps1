Write-Host "This line goes to stdout"
[Console]::Error.WriteLine("This line goes to stderr")
Write-Error "This is a PowerShell error record written to stderr" -ErrorAction Continue

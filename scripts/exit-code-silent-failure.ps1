try {
    throw "Simulated failure inside try/catch"
}
catch {
    Write-Host "POWERSHELL ERROR: $($_.Exception.Message)"
    # Intentionally NOT calling exit here — demonstrates that PowerShell
    # can return exit code 0 after a caught error unless exit is called explicitly.
}

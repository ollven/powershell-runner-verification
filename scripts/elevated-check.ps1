$isWindows = $PSVersionTable.PSEdition -eq 'Desktop' -or $PSVersionTable.Platform -eq 'Win32NT'

if ($isWindows) {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    $isAdmin = $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    Write-Host "Running elevated (Administrator): $isAdmin"
}
else {
    $uid = (id -u)
    Write-Host "Running as root (uid 0): $($uid -eq '0')"
}

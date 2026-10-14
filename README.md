# PowerShell Runner Verification

Pet project for manually verifying the TeamCity PowerShell build runner.
Each script in `scripts/` targets one runner feature. Create one build
configuration per row below, pointed at the matching script, and check
that the actual result matches the expected result.

| Script | Runner setting to configure | Expected result |
|---|---|---|
| `exit-code-success.ps1` | Execution mode: File, no special settings | Build passes |
| `exit-code-failure.ps1` | Execution mode: File | Build fails (non-zero exit code) |
| `exit-code-silent-failure.ps1` | Execution mode: File, add a failure condition on log message containing `POWERSHELL ERROR` | Build fails even though the script's own exit code is 0 |
| `stderr-output.ps1` | Run once with "Format stderr output as" = `warning` (default), once with `error` | `warning`: build passes, stderr lines shown as warnings. `error`: build fails, stderr lines shown as errors |
| `script-arguments.ps1` | Execution mode: File; Script arguments: `-name %env.USERNAME% -buildNumber %build.number%` | Script log shows the substituted parameter values |
| `version-bitness-info.ps1` | Vary PowerShell "Version" (e.g. 5.1, 7.x) and "Platform" (x86/x64/Auto), and "Edition" (Desktop/Core) | Output matches the selected version/bitness/edition; mismatched requirements should fail agent requirement checks |
| `working-directory-check.ps1` | Set "Working directory" to a subdirectory of the checkout dir | Printed location matches the configured working directory |
| `encoding-test.ps1` | Try with and without `teamcity.runner.commandline.stdstreams.encoding=UTF-8` build parameter | Non-ASCII text renders correctly only when UTF-8 encoding is set |
| `teamcity-service-message.ps1` | Execution mode: File | Build log shows the custom status text and progress message parsed as real TeamCity service messages |
| `elevated-check.ps1` | Run normally, then via the RunAs plugin if available | Confirms whether the process is elevated/root |

## Other things to verify manually (not script-dependent)

- **Script execution mode**: compare "Execute .ps1 script from external file", "stdin mode", and the deprecated `-Command` mode.
- **Source mode**: paste one of the scripts directly into the "Source" field instead of referencing the file, and confirm `%build_parameter%` substitution still works.
- **Docker image**: run the same build step with a Docker image set (e.g. an image with `pwsh` on PATH) and confirm it still executes.
- **Additional command line parameters**: pass something like `-NoProfile` and confirm it reaches `powershell.exe`/`pwsh`.
- **Temp file retention**: set `teamcity.dont.delete.temp.files=true` and confirm the generated entry-point script survives in the build temp directory.

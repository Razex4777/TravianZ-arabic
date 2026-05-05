param(
    [Parameter(Mandatory=$true)]
    [string]$ConfigFile,

    [Parameter(Mandatory=$true)]
    [string]$Port,

    [Parameter(Mandatory=$false)]
    [string]$ApachePort = '80'
)

if (-not (Test-Path $ConfigFile)) {
    Write-Host "  [SKIP] config.php not found at: $ConfigFile"
    exit 0
}

$content = [System.IO.File]::ReadAllText($ConfigFile)

# Patch SQL_SERVER to 127.0.0.1
$content = $content -creplace '(?<=define\("SQL_SERVER",\s*")[^"]*', '127.0.0.1'

# Patch SQL_PORT — handles both 3306 (integer) and "3306" (quoted string)
$content = $content -creplace '(?<=define\("SQL_PORT",\s*)\d+', $Port
$content = $content -creplace '(?<=define\("SQL_PORT",\s*")\d+', $Port

# Patch SQL_USER to root
$content = $content -creplace '(?<=define\("SQL_USER",\s*")[^"]*', 'root'

# Patch SQL_PASS to empty string
$content = $content -creplace '(?<=define\("SQL_PASS",\s*")[^"]*', ''

# Patch DOMAIN/HOMEPAGE/SERVER with correct Apache port
$apacheUrl = if ($ApachePort -eq '80') { 'http://localhost/travian/' } else { "http://localhost:$ApachePort/travian/" }
$content = $content -creplace '(?<=define\("DOMAIN",\s*")[^"]*', $apacheUrl
$content = $content -creplace '(?<=define\("HOMEPAGE",\s*")[^"]*', $apacheUrl
$content = $content -creplace '(?<=define\("SERVER",\s*")[^"]*', $apacheUrl

[System.IO.File]::WriteAllText($ConfigFile, $content)
Write-Host "  [OK] Patched config.php - SQL_PORT=$Port, Apache=$ApachePort"

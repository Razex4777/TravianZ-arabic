$en = Get-Content 'GameEngine\Lang\en.php' -Raw
$ar = Get-Content 'GameEngine\Lang\ar.php' -Raw
$pattern = "define\('([^']+)'"
$enDefines = [regex]::Matches($en, $pattern) | ForEach-Object { $_.Groups[1].Value }
$arDefines = [regex]::Matches($ar, $pattern) | ForEach-Object { $_.Groups[1].Value }
$missing = $enDefines | Where-Object { $_ -notin $arDefines }
Write-Host "EN defines: $($enDefines.Count)"
Write-Host "AR defines: $($arDefines.Count)"
Write-Host "Missing in AR: $($missing.Count)"
if ($missing.Count -gt 0) { $missing | ForEach-Object { Write-Host $_ } }

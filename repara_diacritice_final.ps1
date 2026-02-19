# repara_diacritice_final.ps1 - Repara diacriticele in toate articolele

$blogDir = "C:\Users\Lucian\.openclaw\workspace\blog-deploy"
$postsDir = Join-Path $blogDir "_posts"

Write-Host "=== REPARARE DIACRITICE FINALA ==="
Write-Host "Director: $postsDir"

# Get all markdown files
$files = Get-ChildItem -Path $postsDir -Filter "*.md"

Write-Host "`nFisiere gasite: $($files.Count)"

foreach ($file in $files) {
    Write-Host "`nProcesare: $($file.Name)"
    
    # Read file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Check if content has encoding issues
    $hasIssues = $false
    
    # Common encoding issues in Romanian
    $replacements = @{
        'Äƒ' = 'ă'
        'Ã®' = 'î'
        'Ã¢' = 'â'
        'È›' = 'ț'
        'È˜' = 'Ș'
        'Èš' = 'ș'
        'ÅŸ' = 'ș'
        'Å£' = 'ț'
        'ÃŽ' = 'Î'
        'Ã‚' = 'Â'
        'Ã' = 'Ă'
        'Ã¨' = 'è'
        'Ã©' = 'é'
        'Ãª' = 'ê'
        'Ã«' = 'ë'
        'Ã¬' = 'ì'
        'Ã­' = 'í'
        'Ã®' = 'î'
        'Ã¯' = 'ï'
        'Ã°' = 'ð'
        'Ã±' = 'ñ'
        'Ã²' = 'ò'
        'Ã³' = 'ó'
        'Ã´' = 'ô'
        'Ãµ' = 'õ'
        'Ã¶' = 'ö'
        'Ã·' = '÷'
        'Ã¸' = 'ø'
        'Ã¹' = 'ù'
        'Ãº' = 'ú'
        'Ã»' = 'û'
        'Ã¼' = 'ü'
        'Ã½' = 'ý'
        'Ã¾' = 'þ'
        'Ã¿' = 'ÿ'
    }
    
    $newContent = $content
    foreach ($key in $replacements.Keys) {
        if ($newContent -match $key) {
            $hasIssues = $true
            $newContent = $newContent -replace $key, $replacements[$key]
        }
    }
    
    if ($hasIssues) {
        Write-Host "  ✗ Probleme de encoding detectate"
        
        # Save with UTF8 encoding
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.Encoding]::UTF8)
        Write-Host "  ✓ Fisier reparat si salvat cu UTF8"
    } else {
        Write-Host "  ✓ Encoding OK"
    }
}

Write-Host "`n=== VERIFICARE EXEMPLU ==="

# Check first file
$firstFile = Get-ChildItem -Path $postsDir -Filter "*.md" | Select-Object -First 1
if ($firstFile) {
    Write-Host "Primul fisier: $($firstFile.Name)"
    
    # Read first 5 lines
    $content = Get-Content -Path $firstFile.FullName -TotalCount 5
    foreach ($line in $content) {
        Write-Host "  $line"
    }
}

Write-Host "`n=== REPARARE COMPLETATA ==="
Write-Host "Ruleaza 'git add .' si 'git commit -m \"Reparare diacritice\"'"
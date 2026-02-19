# final_fix_encoding.ps1 - Repara encoding-ul final

$postsDir = "C:\Users\Lucian\.openclaw\workspace\blog-deploy\_posts"

Write-Host "=== REPARARE FINALA ENCODING ==="

$files = Get-ChildItem -Path $postsDir -Filter "*.md"

foreach ($file in $files) {
    Write-Host "`nProcessing: $($file.Name)"
    
    # Read file as bytes to handle BOM
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    
    # Remove UTF-8 BOM if present (EF BB BF)
    if ($bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        $bytes = $bytes[3..($bytes.Length-1)]
        Write-Host "  Removed UTF-8 BOM"
    }
    
    # Convert bytes to string assuming UTF-8
    $content = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    # Fix common encoding issues
    $replacements = @(
        @('Äƒ', 'ă'),
        @('Ã®', 'î'),
        @('Ã¢', 'â'),
        @('È›', 'ț'),
        @('È˜', 'Ș'),
        @('Èš', 'ș'),
        @('ÅŸ', 'ș'),
        @('Å£', 'ț'),
        @('ÃŽ', 'Î'),
        @('Ã‚', 'Â'),
        @('Ã', 'Ă'),
        @('Ã¨', 'è'),
        @('Ã©', 'é'),
        @('Ãª', 'ê'),
        @('Ã«', 'ë'),
        @('Ã¬', 'ì'),
        @('Ã­', 'í'),
        @('Ã®', 'î'),
        @('Ã¯', 'ï'),
        @('Ã°', 'ð'),
        @('Ã±', 'ñ'),
        @('Ã²', 'ò'),
        @('Ã³', 'ó'),
        @('Ã´', 'ô'),
        @('Ãµ', 'õ'),
        @('Ã¶', 'ö'),
        @('Ã·', '÷'),
        @('Ã¸', 'ø'),
        @('Ã¹', 'ù'),
        @('Ãº', 'ú'),
        @('Ã»', 'û'),
        @('Ã¼', 'ü'),
        @('Ã½', 'ý'),
        @('Ã¾', 'þ'),
        @('Ã¿', 'ÿ'),
        @('â€“', '–'),
        @('â€”', '—'),
        @('â€˜', '‘'),
        @('â€™', '’'),
        @('â€œ', '“'),
        @('â€', '”')
    )
    
    $hasIssues = $false
    foreach ($rep in $replacements) {
        $wrong = $rep[0]
        $correct = $rep[1]
        if ($content -match $wrong) {
            $hasIssues = $true
            $content = $content -replace $wrong, $correct
        }
    }
    
    if ($hasIssues) {
        Write-Host "  Fixed encoding issues"
    }
    
    # Fix specific titles
    $titleMap = @{
        "Dark Web Monitoring: Cum.*" = "Dark Web Monitoring: Cum Știi Dacă Datele Tale Sunt Vândute pe Piața Neagră"
        "Open Source Intelligence.*" = "Open Source Intelligence (OSINT): Ce Pot Strânge Despre Tine Străinii de pe Internet"
        "Identitatea Digitală în Sănătate.*" = "Identitatea Digitală în Sănătate: e-Pacient și Securitatea Datelor Medicale"
        "Social Engineering: Cum.*" = "Social Engineering: Cum Să Nu Te Laseți Păcălit de Atacatorii Psihologici"
        "GDPR în Practică: Cum.*" = "GDPR în Practică: Cum să Îți Protejezi Drepturile în Era Digitală"
        "Identitate Digitală și Metaverse.*" = "Identitate Digitală și Metaverse: Ce Ne Așteaptă în Lumea Virtuală"
        "Identitatea Digitală pentru Părinți.*" = "Identitatea Digitală pentru Părinți: Cum să Îți Protejezi Copilul Online"
    }
    
    foreach ($pattern in $titleMap.Keys) {
        if ($content -match "title: `"$pattern`"") {
            $newTitle = $titleMap[$pattern]
            $content = $content -replace "title: `"$pattern`"", "title: `"$newTitle`""
            Write-Host "  Fixed title to: $newTitle"
        }
    }
    
    # Save with UTF-8 without BOM
    [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
    Write-Host "  Saved with UTF-8 (no BOM)"
}

Write-Host "`n=== VERIFICARE ==="

$sampleFile = Get-ChildItem -Path $postsDir -Filter "*.md" | Select-Object -First 1
if ($sampleFile) {
    Write-Host "Sample file: $($sampleFile.Name)"
    $content = Get-Content $sampleFile.FullName -TotalCount 5
    foreach ($line in $content) {
        Write-Host "  $line"
    }
}

Write-Host "`n=== FINALIZAT ==="
Write-Host "Ruleaza: git add . && git commit -m 'Reparare completa encoding' && git push"
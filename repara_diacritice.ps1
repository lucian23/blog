# repara_diacritice.ps1 - Repara diacriticele in numele fisierelor si continut

$blogDir = "C:\Users\Lucian\.openclaw\workspace\blog-deploy"
$postsDir = Join-Path $blogDir "_posts"

Write-Host "=== REPARARE DIACRITICE BLOG ==="
Write-Host "Director posts: $postsDir"

# Lista fisierelor cu probleme
$fisiereProblema = Get-ChildItem -Path $postsDir -Filter "*.md"

Write-Host "`nFisiere gasite: $($fisiereProblema.Count)"

foreach ($fisier in $fisiereProblema) {
    $numeVechi = $fisier.Name
    Write-Host "`nProcesare: $numeVechi"
    
    # Decode nume fisier (inlocuieste caractere gresite)
    $numeNou = $numeVechi -replace '\?', 'ț'  # ? -> ț
    $numeNou = $numeNou -replace '�', 'ă'     # � -> ă
    $numeNou = $numeNou -replace 'Ä', 'Ă'     # Ä -> Ă
    $numeNou = $numeNou -replace '�', 'â'     # � -> â
    $numeNou = $numeNou -replace '�', 'î'     # � -> î
    $numeNou = $numeNou -replace '�', 'ș'     # � -> ș
    $numeNou = $numeNou -replace '�', 'Ș'     # � -> Ș
    $numeNou = $numeNou -replace '�', 'â'     # � -> â
    
    if ($numeNou -ne $numeVechi) {
        Write-Host "  Renumește: $numeVechi"
        Write-Host "        ->: $numeNou"
        
        $caleVeche = Join-Path $postsDir $numeVechi
        $caleNoua = Join-Path $postsDir $numeNou
        
        # Citeste continutul cu encoding corect
        try {
            $continut = Get-Content -Path $caleVeche -Raw
            # Salveaza cu UTF8
            Set-Content -Path $caleNoua -Value $continut -Encoding UTF8
            Write-Host "  ✓ Fisier salvat cu UTF8"
            
            # Sterge fisierul vechi
            Remove-Item -Path $caleVeche
            Write-Host "  ✓ Fisier vechi sters"
        }
        catch {
            Write-Host "  ✗ Eroare: $_"
        }
    } else {
        Write-Host "  ✓ Nume OK"
    }
}

Write-Host "`n=== VERIFICARE CONTINUT ==="

# Verifica continutul primului fisier
$fisiereNoi = Get-ChildItem -Path $postsDir -Filter "*.md" | Select-Object -First 1
if ($fisiereNoi) {
    $primulFisier = $fisiereNoi[0]
    Write-Host "Verificare: $($primulFisier.Name)"
    
    # Citeste primele 5 linii
    $continut = Get-Content -Path $primulFisier.FullName -TotalCount 10
    foreach ($linie in $continut) {
        Write-Host "  $linie"
    }
}

Write-Host "`n=== REPARARE COMPLETATA ==="
Write-Host "Ruleaza 'git status' pentru a vedea modificările"
Write-Host "Apoi 'git add .' si 'git commit -m \"Reparare diacritice\"'"
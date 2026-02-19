# fix_encoding.ps1 - Fix file encoding and names

$blogDir = "C:\Users\Lucian\.openclaw\workspace\blog-deploy"
$postsDir = Join-Path $blogDir "_posts"

Write-Host "=== FIX ENCODING BLOG ==="

# Get all markdown files
$files = Get-ChildItem -Path $postsDir -Filter "*.md"

Write-Host "Found files: $($files.Count)"

foreach ($file in $files) {
    $oldName = $file.Name
    Write-Host "`nProcessing: $oldName"
    
    # Fix filename encoding
    $newName = $oldName
    
    # Common encoding issues
    $newName = $newName -replace '\?', 'ț'
    $newName = $newName -replace '�', 'ă'
    $newName = $newName -replace 'Ä', 'Ă'
    $newName = $newName -replace '�', 'â'
    $newName = $newName -replace '�', 'î'
    $newName = $newName -replace '�', 'ș'
    $newName = $newName -replace '�', 'Ș'
    
    if ($newName -ne $oldName) {
        Write-Host "  Rename: $oldName"
        Write-Host "      to: $newName"
        
        $oldPath = Join-Path $postsDir $oldName
        $newPath = Join-Path $postsDir $newName
        
        # Read content
        $content = Get-Content -Path $oldPath -Raw
        
        # Write with UTF8
        [System.IO.File]::WriteAllText($newPath, $content, [System.Text.Encoding]::UTF8)
        Write-Host "  Saved with UTF8"
        
        # Delete old file
        Remove-Item -Path $oldPath
        Write-Host "  Old file deleted"
    } else {
        Write-Host "  Name OK"
    }
}

Write-Host "`n=== CHECKING CONTENT ==="

# Check first file
$newFiles = Get-ChildItem -Path $postsDir -Filter "*.md"
if ($newFiles) {
    $firstFile = $newFiles[0]
    Write-Host "First file: $($firstFile.Name)"
    
    # Read first 5 lines
    $content = Get-Content -Path $firstFile.FullName -TotalCount 5
    foreach ($line in $content) {
        Write-Host "  $line"
    }
}

Write-Host "`n=== DONE ==="
Write-Host "Run: git status"
Write-Host "Then: git add ."
Write-Host "Then: git commit -m 'Fix encoding issues'"
Write-Host "Then: git push"
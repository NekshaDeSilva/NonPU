$repoPath = "c:\Users\HP\Desktop\NonPU"
Set-Location $repoPath

$commitMessages = @("updated", "updated", "updated", "updated", "updated")

$filesToModify = @(
    "neuronalpipes.v",
    "fb_ram.v",
    "activitymonitor.v",
    "superneuron.v",
    "sheet.v",
    "spike2letter.v",
    "nonpu.v",
    "top_nonpu.v",
    "readme.md"
)

$global:fileIndex = 0

function Make-Commit {
    param (
        [DateTime]$commitDate,
        [string]$message
    )
    
    $global:fileIndex = ($global:fileIndex + 1) % $filesToModify.Count
    $fileToModify = $filesToModify[$global:fileIndex]
    $filePath = Join-Path $repoPath $fileToModify
    
    $timestamp = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
    
    if ($fileToModify -eq "readme.md") {
        $commentLine = "`n<!-- $timestamp -->"
    } else {
        $commentLine = "`n// $timestamp"
    }
    
    Add-Content -Path $filePath -Value $commentLine
    
    $dateStr = $commitDate.ToString("yyyy-MM-ddTHH:mm:ss")
    
    git add $fileToModify
    $env:GIT_AUTHOR_DATE = $dateStr
    $env:GIT_COMMITTER_DATE = $dateStr
    git commit -m $message --date=$dateStr
    
    Write-Host "Commit: $message on $dateStr"
}

Write-Host "Creating new commit history..."

git checkout --orphan temp_history
git reset

$initialDate = [DateTime]::new(2025, 12, 3, 10, 0, 0)
$env:GIT_AUTHOR_DATE = $initialDate.ToString("yyyy-MM-ddTHH:mm:ss")
$env:GIT_COMMITTER_DATE = $initialDate.ToString("yyyy-MM-ddTHH:mm:ss")
git add -A
git commit -m "updated" --date="$($initialDate.ToString('yyyy-MM-ddTHH:mm:ss'))"
Write-Host "Initial commit on $($initialDate.ToString('yyyy-MM-dd'))"

Write-Host "Phase 1: Dec 4 - Jan 6 (2 commits per day)"
$startDate = [DateTime]::new(2025, 12, 4, 9, 0, 0)
$endDate = [DateTime]::new(2026, 1, 6, 23, 59, 59)
$currentDate = $startDate

while ($currentDate -le $endDate) {
    for ($i = 0; $i -lt 2; $i++) {
        $hour = 9 + ($i * 5) + (Get-Random -Minimum 0 -Maximum 3)
        $minute = Get-Random -Minimum 0 -Maximum 59
        $commitTime = $currentDate.Date.AddHours($hour).AddMinutes($minute)
        Make-Commit -commitDate $commitTime -message "updated"
    }
    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Phase 2: Jan 7 - Jan 31 (1 commit per week)"
$weeklyDates = @(
    [DateTime]::new(2026, 1, 10, 14, 30, 0),
    [DateTime]::new(2026, 1, 17, 11, 15, 0),
    [DateTime]::new(2026, 1, 24, 16, 45, 0),
    [DateTime]::new(2026, 1, 31, 10, 20, 0)
)

foreach ($commitDate in $weeklyDates) {
    Make-Commit -commitDate $commitDate -message "updated"
}

Write-Host "Phase 3: Feb 1 - Feb 5 (5 commits per day)"
$startDate = [DateTime]::new(2026, 2, 1, 8, 0, 0)
$endDate = [DateTime]::new(2026, 2, 5, 18, 0, 0)
$currentDate = $startDate

while ($currentDate -le $endDate) {
    for ($i = 0; $i -lt 5; $i++) {
        $hour = 8 + ($i * 2) + (Get-Random -Minimum 0 -Maximum 1)
        $minute = Get-Random -Minimum 0 -Maximum 59
        $commitTime = $currentDate.Date.AddHours($hour).AddMinutes($minute)
        Make-Commit -commitDate $commitTime -message "updated"
    }
    $currentDate = $currentDate.AddDays(1)
}

Write-Host "Finalizing..."
git branch -D main 2>$null
git branch -m main

Write-Host "Done! Run: git push -f origin main"

Remove-Item Env:\GIT_AUTHOR_DATE -ErrorAction SilentlyContinue
Remove-Item Env:\GIT_COMMITTER_DATE -ErrorAction SilentlyContinue

# ==========================================================
# Execution Policy (Process scope only)
# ==========================================================
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# ==========================================================
# 1. Force Windows 11 to use the classic context menu
#    (Skip "Show more options")
# ==========================================================
$classicContextMenuKey = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"
New-Item -Path $classicContextMenuKey -Force | Out-Null
Set-ItemProperty -Path $classicContextMenuKey -Name "(default)" -Value ""

# ==========================================================
# 2. Completely reset Explorer Bags
#    (Include all existing folders)
# ==========================================================
$bagsRoot = "HKCU:\Software\Microsoft\Windows\Shell"

Remove-Item "$bagsRoot\Bags" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "$bagsRoot\BagMRU" -Recurse -Force -ErrorAction SilentlyContinue

New-Item "$bagsRoot\Bags" -Force | Out-Null
New-Item "$bagsRoot\BagMRU" -Force | Out-Null

# ==========================================================
# 3. Apply global folder settings
#    - Disable grouping
#    - Force view mode
# ==========================================================
$allFoldersShell = "$bagsRoot\Bags\AllFolders\Shell"
New-Item $allFoldersShell -Force | Out-Null

# Disable grouping (Group by: None)
Set-ItemProperty $allFoldersShell -Name "GroupBy" -Value ""

# Set view mode
# Mode values:
# 1 = Large icons
# 2 = Small icons
# 3 = List
# 4 = Details
# 5 = Tiles
# 6 = Content
Set-ItemProperty $allFoldersShell -Name "Mode" -Type DWord -Value 4

# Stabilize detailed view layout
Set-ItemProperty $allFoldersShell -Name "LogicalViewMode" -Type DWord -Value 1

# ==========================================================
# 4. Override folder templates
#    (Documents / Pictures / Music / Videos, etc.)
# ==========================================================
$templates = @(
    "{7d49d726-3c21-4f05-99aa-fdc2c9474656}", # Generic
    "{5fa96407-7e77-483c-ac93-691d05850de8}", # Documents
    "{94d6ddcc-4a68-4175-a374-bd584a510b78}", # Pictures
    "{b3690e58-e961-423b-b687-386ebfd83239}", # Music
    "{5f4eabf5-16ef-4cd3-8cce-0a1d1c9d8c67}"  # Videos
)

foreach ($tpl in $templates) {
    $tplPath = "$bagsRoot\Bags\AllFolders\Shell\$tpl"
    New-Item $tplPath -Force | Out-Null
    Set-ItemProperty $tplPath -Name "GroupBy" -Value ""
    Set-ItemProperty $tplPath -Name "Mode" -Type DWord -Value 4
}

# ==========================================================
# 5. Restart Explorer to apply changes
# ==========================================================
Get-Process explorer -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Process explorer.exe

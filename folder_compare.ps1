# Define folder paths
$folder1 = "C:\Path\To\First\Folder"
$folder2 = "C:\Path\To\Second\Folder"

# Define output file path
$outputFile = "C:\Path\To\Output\common-files.txt"

# Get file names from both folders
$filesInFolder1 = Get-ChildItem -Path $folder1 -File | Select-Object -ExpandProperty Name
$filesInFolder2 = Get-ChildItem -Path $folder2 -File | Select-Object -ExpandProperty Name

# Find common file names
$commonFiles = Compare-Object -ReferenceObject $filesInFolder1 -DifferenceObject $filesInFolder2 -IncludeEqual -ExcludeDifferent | 
               Where-Object { $_.SideIndicator -eq "==" } | 
               Select-Object -ExpandProperty InputObject

# Output results
if ($commonFiles.Count -gt 0) {
    "Files with the same name found in both folders:" | Out-File -FilePath $outputFile
    $commonFiles | Out-File -FilePath $outputFile -Append
    Write-Host "Results saved to $outputFile" -ForegroundColor Green
} else {
    "No files with matching names found in both folders." | Out-File -FilePath $outputFile
    Write-Host "No matching files found. Results saved to $outputFile" -ForegroundColor Yellow
}

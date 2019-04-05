# 
# This script is used for finding CR2 raw photo files and seeing if
# a corresponding JPG file exists. If the JPG file existis then it
# is deleted
#

# Start by removing the output file, if it exists, which lists the files found
#if (Test-Path -Path "D:\Users\damiendb\Documents\Duplicate JPG Files.txt") {
#    Remove-Item "D:\Users\damiendb\Documents\Duplicate JPG Files.txt"
#}

$CR2Counter = 0
$JPGCounter = 0

$PhotoYear = "2019"
$PhotoLocation = "J:\OneDrive\Pictures\Photo Album\"
$PhotoPath = $PhotoLocation + $PhotoYear

$OutputDir = "D:\Users\damiendb\Documents\"
$OutputFile = "Duplicate JPG Files - " + $PhotoYear + ".ps1"
$OutputPath = $OutputDir + $OutputFile

# Start by removing the output file, if it exists, which lists the files found
if (Test-Path -Path $OutputPath) {
    Remove-Item $OutputPath
}

# Change to the  Directory with the Photos
Set-Location $PhotoPath

# Loop through the Directory files
# Finding files with the extension CR2
Get-ChildItem $PhotoPath -Filter "*.CR2" -Recurse | 
Foreach-Object {

    $CR2Counter++
    # Build the path for what the corresponding JPG file would be
    $JPGFile = $_.DirectoryName + "\" + $_.BaseName + ".JPG"
    $DelCmd = 'Remove-Item "' + $JPGFile + '"'

    if (Test-Path -Path $JPGFile) {
        $JPGCounter++
        $DelCmd | Out-File -FilePath $OutputPath -Append
    }
    # $JPGDir = $_.DirectoryName

}

"# Total number of CR2 files found = " + $CR2Counter
"# Total number of JPG files found = " + $JPGCounter

"# Total number of CR2 files found = " + $CR2Counter | Out-File -FilePath $OutputPath -Append
"# Total number of JPG files found = " + $JPGCounter | Out-File -FilePath $OutputPath -Append




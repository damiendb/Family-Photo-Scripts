# 
#

# Set Photo Location Variable
$PhotoDirectory = "X:\Dev's iPhone\New Photos"
$OneDriveDirectory = "J:\OneDrive\Pictures\Photo Album\2017"
$PhotoListFile = "X:\Dev's iPhone\List of Photos.txt"
$Counter = 0

# Change to the  Directory with the Photos
Set-Location $PhotoDirectory

# Loop through each of the new photos
Get-ChildItem $PhotoDirectory | 
ForEach-Object {

    $Counter++
    $Counter

    $FullFilename = $_.FullName
    $FileLength = $_.Length
    $FilenameandLength = $FullFilename + ", " + $FileLength
    
    # Loop through the OneDrive directory to be compared against
    Get-ChildItem $OneDriveDirectory -Recurse |
    ForEach-Object {
    
        # if the file sizes match then write the details to a txt file
        if ($FileLength -eq $_.Length) {
            
            $_.BaseName
            $FileLength
            $_.Length
            
            $MatchingFile = $_.FullName + " - " +  $FullFilename
            Add-Content $PhotoListFile $MatchingFile 
        }
    }


}
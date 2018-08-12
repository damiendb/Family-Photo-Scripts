# 
# This script is used for photos from Devyn's iPhone
# Specifically it's for photos with the date taken in the Filename
# 
# Last run: 5 November 2017
# Last photos transferred
#     Devyn: 20 October 2017
#     Damien: none
#

# Change to the  Directory with the Photos
Set-Location "X:\Dev's iPhone\New Photos 2012"

# Loop through the Directory files
Get-ChildItem "X:\Dev's iPhone\New Photos 2012" | 
Foreach-Object {

    # Create variable in the format yyyy-mm-dd
    $NewDirName = $_.BaseName.Substring(0,4) + "-" + $_.BaseName.Substring(4,2) + "-" + $_.BaseName.Substring(6,2)   

    # Create new directory for the day the photo was taken
    mkdir $NewDirName

    # Move the file to the new directory
    Move-Item -Path $_.FullName -Destination $NewDirName

}


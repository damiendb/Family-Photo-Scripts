# 
# This script is used for photos from Damien's OneDrive Camera Roll
# Specifically it's for photos with the date taken in the Filename
#
# Last run: 3 August 2018
# Last photos transferred
#     Damien: 3 August 2018
#

# Change to the  Directory with the Photos
Set-Location "C:\Camera Roll\Photo Album"

# Loop through the Directory files
# Finding files with the format WP_YYYYMMDD
Get-ChildItem "C:\Camera Roll\Sort\WP_201*.jpg" | 
Foreach-Object {

    # Create variable in the format yyyy-mm-dd
    $NewDirName = $_.BaseName.Substring(3,4) + "-" + $_.BaseName.Substring(7,2) + "-" + $_.BaseName.Substring(9,2)   

    # Create new directory for the day the photo was taken
    mkdir $NewDirName

    # Move the file to the new directory
    Move-Item -Path $_.FullName -Destination $NewDirName

}

# Finding files with the format IMG_YYYYMMDD
Get-ChildItem "C:\Camera Roll\Sort\IMG_201*.jpg" | 
Foreach-Object {

    # Create variable in the format yyyy-mm-dd
    $NewDirName = $_.BaseName.Substring(4,4) + "-" + $_.BaseName.Substring(8,2) + "-" + $_.BaseName.Substring(10,2)   

    # Create new directory for the day the photo was taken
    mkdir $NewDirName

    # Move the file to the new directory
    Move-Item -Path $_.FullName -Destination $NewDirName

}

# Finding files with the format MVIMG_YYYYMMDD
Get-ChildItem "C:\Camera Roll\Sort\MVIMG_201*.jpg" | 
Foreach-Object {

    # Create variable in the format yyyy-mm-dd
    $NewDirName = $_.BaseName.Substring(6,4) + "-" + $_.BaseName.Substring(10,2) + "-" + $_.BaseName.Substring(12,2)   

    # Create new directory for the day the photo was taken
    mkdir $NewDirName

    # Move the file to the new directory
    Move-Item -Path $_.FullName -Destination $NewDirName

}

# Finding files with the format YYYYMMDD
Get-ChildItem "C:\Camera Roll\Sort\201*.jpg" | 
Foreach-Object {

    # Create variable in the format yyyy-mm-dd
    $NewDirName = $_.BaseName.Substring(0,4) + "-" + $_.BaseName.Substring(4,2) + "-" + $_.BaseName.Substring(6,2)   

    # Create new directory for the day the photo was taken
    mkdir $NewDirName

    # Move the file to the new directory
    Move-Item -Path $_.FullName -Destination $NewDirName

}
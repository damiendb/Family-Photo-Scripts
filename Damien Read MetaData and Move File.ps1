# 
# This script is used for photos from Damien's OneDrive Camera Roll
# Specifically it's for photos with the date taken stored in MetaData
#
# Last run: 11 August 2018
# Last photos transferred
#     Damien: 11 August 2018
#
#Requires -Version 4

function Get-Images {
    <# 
     .SYNOPSIS
      Script to get image file information like 'DateTaken'
    
     .DESCRIPTION
      Script to get image file information like 'DateTaken'
      Script returns a PS object containing image file(s) information
    
     .PARAMETER Source
      Path to one or more folders where image files are located
    
     .PARAMETER Extension
      One or more image file extensions, such as .jpg and .gif
      If no extensions are specified, the script looks for .jpg and .gif 
      image files by default.
    
     .EXAMPLE
      Get-Images -Source E:\Pictures\001 -Extension .jpg
      This example will return information on image files with .jpg extension in the given folder and its subfolders
    
     .EXAMPLE
      Get-Images e:\pictures\001,e:\pictures\005 -Verbose
      This example gets image information on images files in the 2 specified folders, showing verbose messages during processing
    
     .EXAMPLE
      $Images = Get-Images e:\pictures\001,e:\pictures\005 | 
        Select Name,@{N='Size(KB)';E={[Math]::Round($_.Size/1KB,0)}},DateTaken,CameraMaker,Width,Height | Sort DateTaken -Descending
      $Images | Format-Table -AutoSize # Display on console
      $Images | Out-GridView # Disply on PowerShell_ISE gridview
      $Images | Export-CSV .\myimages.csv -NoType # Save to CSV
    
     .EXAMPLE
        # Move image files from $SourceFolders to year based folders under $RootFolder based on DateTaken
        $SourceFolders = @('e:\pictures\001','e:\pictures\005')
        $RootFolder    = 'd:\sandbox\pics'
        Get-Images $SourceFolders | % {
            $YearTaken = $_.DateTaken.Split('/')[2].Split(' ')[0]
            if (-not (Test-Path -Path "$RootFolder\$YearTaken")) { 
                "Creating folder '$RootFolder\$YearTaken'"
                New-Item -Path "$RootFolder\$YearTaken" -ItemType Directory -Force -Confirm:$false
            }
            "Moving image '$($_.Name)' from '$(Split-Path -Path $_.FullName )' to '$RootFolder\$YearTaken'"
            Move-Item -Path $_.FullName -Destination "$RootFolder\$YearTaken" -Force -Confirm:$false
        }
    
     .OUTPUTS
      Script will return an array of PS Objects, each has the following properties:
        Name         
        FullName      
        Size         
        Type         
        Extension     
        DateModified 
        DateCreated   
        DateAccessed  
        DateTaken   
        CameraModel  
        CameraMaker  
        BitDepth      
        HorizontalRes 
        VerticalRes 
        Width       
        Height        
    
     .LINK
      http://superwidgets.wordpress.com/category/powershell/
      http://superwidgets.wordpress.com/2014/08/15/powershell-script-to-get-detailed-image-file-information-such-as-datetaken/
      
     .NOTES
      Script by Sam Boutros
      v1.0 - 1/11/2015
    
    #>
    
        [CmdletBinding()] 
        Param(
        [Parameter(Mandatory=$true,  Position=0)]
            [ValidateScript({ (Test-Path -Path $_) })]
            [String[]]$Source, 
        [Parameter(Mandatory=$false, Position=1)]
            [String[]]$Extension = @('.jpg','.gif')
        )
    
        # Get folder list
        $Folders = @()
        $Duration = Measure-Command { 
            $Source | % { $Folders += (Get-ChildItem -Path $Source -Recurse -Directory -Force).FullName }
        }
        $Folders = $Source
    
        $Images = @()
        $objShell  = New-Object -ComObject Shell.Application
        $Folders | % {
    
            $objFldr = $objShell.namespace($_)
            foreach ($File in $objFldr.items()) { 
    
                Write-Host "Processing file '$($File.Path)'"
    
                $DateofPhoto = [DateTime] $objFldr.getDetailsOf($File,3)
                Write-Host $DateofPhoto.ToShortDateString()
    
                $NewDirName = $DateofPhoto.ToString("yyyy-MM-dd")
                Write-Host $NewDirName
    
                # Create new directory for the day the photo was taken
                mkdir $NewDirName
    
                # Move the file to the new directory
                Move-Item -Path $File.Path -Destination $NewDirName
    
            } # foreach $File
    
        } # foreach $Folder
        $Images
    
    } # function
    
    
# Change to the  Directory with the Photos
#Set-Location "C:\Camera Roll\Test Move"
Set-Location "C:\Camera Roll\Photo Album"

$SourceFolders = @('C:\Camera Roll\Snapchat')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Sort')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Videos')
Get-Images $SourceFolders


Set-Location "C:\Camera Roll\Photo Album (Compare Files)"
$SourceFolders = @('C:\Camera Roll\Burst')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Facebook')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Facebook Messenger GIFs')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Instagram')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Lightroom')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\PhotoShop Mobile')
Get-Images $SourceFolders
$SourceFolders = @('C:\Camera Roll\Receipts')
Get-Images $SourceFolders






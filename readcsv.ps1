Set-Location -Path "D:\20240604 373 550\550"
# $directory = 
$type = "*.csv"

$des = "D:\output550\jlist.csv"


$path = [System.IO.Directory]::EnumerateFiles(($pwd).path, $type, 'AllDirectories')

# $lens = $path.Count

# Write-Host "$lens"

results = foreach($i in $path)
    {

        $filename = [System.IO.Path]::GetFileNameWithoutExtension($i)

        # Import-CSV -Path $i | Format-Table
        $Jcol =  Get-Content $i | Select-Object -Skip 254 | ConvertFrom-Csv  | Select-Object -ExpandProperty "Jdensity" 
        
        # Add-Content -Value "$Jcol" -Path $des

        # $output | Add-Member -NotePropertyName $filename -NotePropertyValue $Jcol

        # Write-Host "$Jcol"

        [PSCustomObject]@{
            ID = $filename
            current = $Jcol
        }
        # Out-Gridview
        # Import-Csv  | Select-Object -Skip 254 | Format-Table
        
        # Out-Gridview
        # | ConvertFrom-Csv | Out-File -Path "D:\output550\$i.basename.txt"
     
        
        # Write-Host "$filename"

    }


# $output | Sort-Object Files -Descending | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $des

# Export-CSV -Path $exportto -NoTypeInformation -Delimiter ":" -Encoding UTF8
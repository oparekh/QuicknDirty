#$timezone = Get-TimeZone
$start = Get-Date -Date "19/03/2022" #-UFormat "%d/%m/%Y"
$Start.ToString("dd/MM/yyy")
$end = Get-Date -Date "17/07/2022"
$End.ToString("dd/MM/yyy")
#$end
$location = "???"
 
while($start -ne $end){
    "{0:d}" -f $start
    $start = $start.AddDays(1)
    Get-VBOLicenseOverviewReport -StartTime $start -EndTime $start -Path $location -Format PDF
    Get-VBOLicenseOverviewReport -StartTime $start -EndTime $start -Path $location -Format CSV
}

$FileList = Get-ChildItem $location -Filter *.csv | ForEach-Object {
    $fileName = $_.Name
    Import-Csv $_.Fullname | Select-Object @{
        Name = 'Date'
        Expression = { $filename } 
    }, *
} | Export-Csv $location"\merged.csv" -NoTypeInformation 

$csvFileList = Get-ChildItem $location -Filter *.csv
$csvFileList




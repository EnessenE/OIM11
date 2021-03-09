$computername = Get-Content env:computername
$servicetag = Get-WmiObject win32_bios | Select-Object -ExpandProperty SerialNumber
$prefix = "DT"
$newpcname = "$prefix$servicetag"
If ($computername -ne $newpcname)
{
          Write-Host "Renaming computer to $newpcname..."
          Rename-Computer -NewName $newpcname
}
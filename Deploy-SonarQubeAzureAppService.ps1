Write-Output 'Copy wwwroot folder'
xcopy wwwroot ..\wwwroot /Y

Write-Output 'Setting Security to TLS 1.2'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Write-Output 'Prevent the progress meter from trying to access the console'
$global:progressPreference = 'SilentlyContinue'

Write-Output 'Getting a list of downloads'
#comment out open source version for Developer.
#$downloadSource = 'https://binaries.sonarsource.com/Distribution/sonarqube/'
#$allDownloads = Invoke-WebRequest -Uri $downloadSource -UseBasicParsing
#$zipFiles = $allDownloads[0].Links | Where-Object { $_.href.EndsWith('.zip') -and !($_.href.contains('alpha') -or $_.href.contains('RC')) }
#$latestFile = $zipFiles[-1]
#$downloadUri = $downloadSource + $latestFile.href
$latestFile = 'sonarqube-developer-7.7.zip'
$downloadSource = 'https://binaries.sonarsource.com/CommercialDistribution/sonarqube-developer/'
$downloadUri = $downloadSource + $latestFile

Write-Output "Downloading '$downloadUri'"
#$outputFile = "..\wwwroot\$($latestFile.href)"
$outputFile = "..\wwwroot\$($latestFile)"
Invoke-WebRequest -Uri $downloadUri -OutFile $outputFile -UseBasicParsing
Write-Output 'Done downloading file'

Write-Output 'Extracting zip'
Expand-Archive -Path $outputFile -DestinationPath ..\wwwroot
Write-Output 'Extraction complete'

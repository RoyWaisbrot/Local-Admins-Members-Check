#Will create a local folder that will hold the output TXT file
if (Test-Path -Path 'C:\it') {
    mkdir -Path 'C:\it\LocalAdminReport'
}
else {
    mkdir -Path 'C:\it\LocalAdminReport'
}

#Gets the computer's local administrator group members
$localAdmins = Get-LocalGroupMember -Group 'Administrators'

#Saves the computers name
$computerName = $env:COMPUTERNAME

#Will check if there are any members of the local admins group other than the Domain Admins and local administrator (for LAPS)
#If there is another user, the script will create a TXT file that contains the host name and list of local administrator users
#For centrelzied management, the file can be copied to a shared folder

if (($localAdmins | ? {$_.Name -notin 'DOMAIN NAME\Domain Admins', "$env:COMPUTERNAME\Administrator"}).count -gt 0) {
    $computerName, $localAdmins | Out-File -FilePath C:\IT\LocalAdminReport\"$computerName.txt"
    Copy-Item -Path C:\IT\LocalAdminReport\"$computerName.txt" -Destination 'PATH TO DESTINATION'
}
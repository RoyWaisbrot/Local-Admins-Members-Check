#Gets the token from Dell's API and receving the relevant Service Tag:
$application ='https://apigtwb2c.us.dell.com/auth/oauth/v2/token';
$username ='Your API Key here'
$password ='Your API Secret here'
$serviceTag = Read-Host -Prompt 'Enter a Service Tag '
$dellURI = 'https://apigtwb2c.us.dell.com/PROD/sbil/eapi/v5/asset-entitlements?servicetags=' + $serviceTag

#Headers for the request:
$creds = @{

    client_Id =$username;
    client_secret =$password;
    grant_type ='client_credentials'
}

#Get command for the Warranty's details:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$getToken = Invoke-RestMethod -Uri $application -Method Post -Body $creds
$delltoken = $GetToken.access_token
$deviceDetails = Invoke-RestMethod -Uri $dellURI -Headers @{'Authorization'="Bearer $dellToken";'Accept'='application/json';'Content-Type'='application/x-www-form-urlencoded'}

#Formats the output to get the Warranty's date:
$warrantyDate = $deviceDetails.entitlements.enddate[1]
$timeFormat = [datetime]::Parse($WarrantyDate)
$dateForOutput = $timeFormat.ToString('MMM-dd-yyyy')

#Device's Details:
$serviceTagForOutput = $deviceDetails.serviceTag
$systemModelForOutput = $deviceDetails.systemDescription

#Output:
"Service Tag: " + $serviceTagForOutput
"Model : " + $systemModelForOutput
"Warranty End Date: " + $dateForOutput
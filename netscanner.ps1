param (
	[Parameter(Mandatory=$true,Position=1)][string]$firstIP,
	[Parameter(Mandatory=$true,Position=2)][string]$lastIP
)

If (!($firstIP) -and ($lastIP)) {
	Write-Host Usage:
	Write-Host  powershell.exe netscanner.ps1 -firstIP <first IP in range> -lastIP <last IP in range>
	Write-Host " "
	Write-Host Example:
	Write-Host  powershell.exe netscanner.ps1 -firstIP 192.168.1.1 -lastIP 192.168.1.254
	Exit
}

function NetCheck {
	param(
		[Parameter(Mandatory=$true)][string]$target
	)
	
	if ((ping -n 1 -w 100 ($target)) -match "Reply") {
		Write-Host $target
	}
}

$network = $firstIP.split(".") | select -first 3 | %{$net += $_ ; $net += "."}
$firstIP = $firstIP.split(".") | select -last 1
$lastIP = $lastIP.split(".") | select -last 1

ForEach ($ip in ($firstIP..$lastIP)) {
	NetCheck -target ($net + $ip)
}

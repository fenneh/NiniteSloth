## Ninite AD Deployment v0.2.1
## github.com/justfen fen@justfen.com @justfen_

## Have to import AD module for AD manipulation
if ((Get-Module | Where-Object { $_.Name -eq "ActiveDirectory" }) -eq $null) { Import-Module ActiveDirectory }

##################################
# Set Variables Here #############
##################################

## The Directory in which NiniteOne sits
$NiniteDir = "R:\Ninite\"
## An example would be "OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"
## This would be equivalent to the following just.fen.com\Computers\Laptops
$OU = "OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"

##################################
# Now set SMTP Variables Below ###
##################################

$domainLook = Get-ADForest
$domainName = $domainLook.domains
$NiniteCache = "$NiniteDir\Cache\"
$NiniteTargets = "$NiniteDir\NiniteTargets.txt"
$NiniteLog  = "$NiniteDir\NiniteResults.csv"
$StartDate = Get-Date

function MachineGenerate {
	# Create a PSDrive to manipulate AD
	New-PSDrive -PSProvider ActiveDirectory -Name ADNinite -Root "" -Server "$domainName" 
	pushd ADNinite:
	Get-ADComputer -Filter * -SearchBase "$OU" | Select -Expand Name | Out-File "$NiniteTargets" -Encoding Default
    popd
    Remove-PSDrive -Name ADNinite
}

# Function to fire off confirmation eMail once it has finished running
function MailReport {
    $smtp = "your.smtp.server"
    $from = "ninite@yourdomain"
    $to = "you@yourdomain"
    $subject = "Ninite Report from $StartDate"
    $body = "Please find attached the log of results"
    $Attach = "$NiniteLog"
    Send-Mailmessage -SmtpServer $smtp -From $from -To $to -Subject $subject -Body $body -Attachments $attach
}

# Actual Program
MachineGenerate
cmd /c NiniteOne.exe /updateonly /remote file:"$NiniteTargets" /disableshortcuts /disableautoupdate /cachepath "$NiniteCache" /silent "$NiniteLog"
MailReport

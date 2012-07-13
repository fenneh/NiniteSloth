## Ninite AD Deployment v0.2
## Wrote by fen www.justfen.com // twitter.com/justfen_/
## github.com/justfen fen@justfen.com

## Have to import AD module for AD maniuplation
Import-Module ActiveDirectory

## Variables
$domainName = "just.fen.com"
## An example would be "OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"
## This would be equivalent to the following just.fen.com\Computers\Laptops
$OU = "OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"
$NiniteCache = "R:\Ninite\Cache\"
$NiniteTargets = "R:\Ninite\NiniteTargets.txt"
$NiniteLog  = "R:\Ninite\NiniteResults.csv"
$NiniteDir = "R:\Ninite\"
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
# Please fill in your SMTP details 

function MailReport {
    $smtp = "your.smtp.server"
    $from = "ninite@yourdomain"
    $to = "you@yourdomain"
    $subject = "Ninite Report from $StartDate"
    $body = "Please find attached the log of results"
    $Attach = "$NiniteLog"
    Send-Mailmessage -SmtpServer $smtp -From $from -To $to -Subject $subject -Body $body -Attachments $attach
}

MachineGenerate
cmd /c NiniteOne.exe /updateonly /remote file:"$NiniteTargets" /disableshortcuts /disableautoupdate /cachepath "$NiniteCache" /silent "$NiniteLog"
MailReport

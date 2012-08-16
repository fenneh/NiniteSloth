## Ninite AD Deployment v0.3
## github.com/justfen fen@justfen.com @justfen_

##################################
# Set Variables Here #############
##################################

## The Directory in which NiniteOne sits
$NiniteDir = "R:\Ninite\"
## The OU of machines which you want to deploy to 
## An example would be "OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"
## Which would be equivalent to the following just.fen.com\Computers\Laptops
$OU = "ad:OU=Laptops,OU=Computers,DC=Just,DC=fen,DC=com"

##################################
# Now set SMTP Variables Below ###
##################################

$NiniteCache = "$NiniteDir\Cache\"
$NiniteLog  = "$NiniteDir\NiniteResults.csv"
$StartDate = Get-Date

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
cmd /c NiniteOne.exe /updateonly /remote "$OU" /disableshortcuts /disableautoupdate /cachepath "$NiniteCache" /silent "$NiniteLog"
MailReport

## Ninite AD Deployment v0.1
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
$NiniteLog  = "R:\Ninite\log.txt"
$NiniteDir = "R:\Ninite\"

function MachineGenerate {
	# Create a PSDrive to manipulate AD
	New-PSDrive -PSProvider ActiveDirectory -Name ADNinite -Root "" -Server "$domainName" 
	chdir ADNinite:
	Get-ADComputer -Filter * -SearchBase "$OU" | Select -Expand Name | Out-File "$NiniteTargets" -Encoding Default
    chdir $NiniteDir
    Remove-PSDrive -Name ADNinite
}

MachineGenerate
cmd /c NiniteOne.exe /updateonly /remote file:"$NiniteTargets" /disableshortcuts /disableautoupdate /cachepath "$NiniteCache" /silent "$NiniteLog"

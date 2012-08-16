# NiniteSloth

The Ninite script is to be used in conjunction with Ninite's "Ninite Pro" service. The idea of the script is to be run as a scheduled task on a server and for it to update all the software on your network.

It's not supposed to be super fancy, but it is supposed to help low budget companies, charities, startups getting over the hurdle of software patching within an organization. 

## Prerequisites

You need the following installed and running to make this script work

* PowerShell (It could be converted to a straight up .bat though!)

You also need to have NiniteOne.exe which is aquired through subscribing to Ninite pro @ https://ninite.com/pro

# Setup

## File/Folder structure

* One folder containing NiniteOne.exe the scripts you have to set the path manually with anyway, but it'd be easier if you packaged them all in the same folder.

## AutoNinite.ps1

Pretty simple, open the script up in a text editor and change all the variables at the top of the file to your Ninite direcetory.

There's other things you want to change in there such as your SMTP server settings & AD roots. Given the uniquness of environments there's not really a "smart" way to do this so there's a tiny bit of legwork before you get it running.

## NiniteOne.bat

Again, open this file up in a text editor and change the paths pointing to the folder in for which the AutoNinite.ps1 script lies. This batch file is really there for a quick and easy way to capture the output and attachment to a scheduled task.

# Additional Flags

If you want some additional functionality then you'll want to read the command line switch references @ https://ninite.com/help/features/switches.html for NiniteOne. Some features you could build in for example is to only update certain packages or freeze installs at certain versions.
# NiniteSloth

PowerShell automation for Ninite Pro. Runs as a scheduled task to keep network software patched without lifting a finger.

Built for low-budget companies, charities, and startups who need proper software patching but don't have proper budgets.

## Requirements

- PowerShell
- Ninite Pro subscription ([ninite.com/pro](https://ninite.com/pro))
- NiniteOne.exe from your subscription

## Setup

1. Place `NiniteOne.exe` and scripts in the same folder
2. Edit `AutoNinite.ps1`:
   - Set your Ninite directory path
   - Configure SMTP server settings
   - Set AD roots for your environment
3. Edit `NiniteOne.bat` with the correct script path
4. Create a scheduled task pointing to `NiniteOne.bat`

## Configuration

The script requires manual configuration because every environment is different. No magic auto-detection here - just honest PowerShell.

## Additional Options

See [Ninite command line reference](https://ninite.com/help/features/switches.html) for advanced options like freezing versions or limiting packages.

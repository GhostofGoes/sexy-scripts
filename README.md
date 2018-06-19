A collection of scripts I use for setting up my environment and doing day-to-day tasks.
Uses native platform tools, namely PowerShell on Windows, and BASH on Linux.

If you want to download "LinkedIn" slideshares, there's also a thing for that.

# Usage

## Linux
```bash
# You'll need wget and unzip, unfortunatly. The other option, of course, is git.
wget https://github.com/GhostofGoes/sneaky-scripts/archive/master.zip
unzip master.zip
cd sneaky-scripts-master
chmod +x ./linux/setup.sh
./linux/setup.sh
```

## Windows
* Download repo and unzip it
* Open a Administrator-level PowerShell prompt in the unzipped directory:
```powershell
.\windows\setup.ps1
```

# Platforms
* Windows: 10 (1604, 1704, 1709. 1803 TBD.)
* Ubuntu: 14, 16, 18
* Kali: 2017+
* CentOS: 6+, 7+

# License
Licensed under the MIT licence. (See LICENSE file for details)
Feel free adapt for your own purposes, or just copy and go.

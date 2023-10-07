# Samora lang Installers

This repository provides scripts to install Samora Lang compiler in various Operating Systems

## How to install

### Windows

Download the [Windows Installer](https://github.com/obadiaspelembe/samora-lang-installers/blob/feat/windows-installer/Windows/installer.ps1).

I really recommend installing golang in your host, although it is not mandatory.

```powershell
./installer.ps1
```

### Linux

For **any** Linux distribution, you just need to make sure you have [curl](https://curl.se/) installed, and just run the following command to install samora-lang

```bash
sudo curl -sSL https://raw.githubusercontent.com/obadiaspelembe/samora-lang-installers/main/Unix/installer.sh | bash
```

You can also install using [wget](https://www.gnu.org/software/wget/)

```bash
sudo wget -O - https://raw.githubusercontent.com/obadiaspelembe/samora-lang-installers/main/Unix/installer.sh | bash
```

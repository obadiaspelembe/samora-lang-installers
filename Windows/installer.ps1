$goInProgramFiles = "C:\Program Files\Go\bin"
$samoraGithubRepo = "https://github.com/GraHms/Samora-Lang"
# Set variables for download URLs and installation paths
$goDownloadUrl = "https://golang.org/dl/go1.17.windows-amd64.msi"
$goInstallerPath = "$env:TEMP\go_installer.msi"
$goInstallPath = "C:\Go" 
$clonePath = "$env:TEMP\Samora"
$smlInstallerPath = "$env:USERPROFILE\Samora"

# Check if go is installed in ProgramFiles
if (!(Test-Path "$goInProgramFiles\go.exe")) {
    Write-Host "Golang executable found under $goInProgramFiles"
} else {

    Write-Host "Golang executable not found"

    if (!(Test-Path "go.exe")) {
        # Downloading Golang installer

        Write-Host "Go installed successfully."
        # Download the Go installer
        Invoke-WebRequest -Uri $goDownloadUrl -OutFile $goInstallerPath
    
        # Install Go
        Start-Process -Wait -FilePath msiexec -ArgumentList "/i $goInstallerPath /qn ADDLOCAL=ALL"
    
        # Set Go environment variables
        $GOPATH = "$env:USERPROFILE\go"
        $PATH += ";$goInstallPath\bin;$GOPATH\bin"

        $existingPath = [Environment]::GetEnvironmentVariable("Path", "User")
        [Environment]::SetEnvironmentVariable("Path", "$existingPath;$PATH", "User")
    
        Write-Host "Go installed successfully."
    }  
}

# Clone the Samora Lang GitHub repository
Write-Host "Cloning Samora Github Repository."
git clone $samoraGithubRepo $clonePath

Set-Location -Path $clonePath

Write-Host "Generating executable compiler."
Invoke-Expression "go build"

# Add Samora Executable Folder to USERPROFILE directory
New-Item -Path "$smlInstallerPath" -ItemType Directory

# Move samora lang to installer folder
Move-Item -Path "$clonePath\samoralang.exe" -Destination "$smlInstallerPath/samora.exe" 

$existingPath = [Environment]::GetEnvironmentVariable("Path", "User")

[Environment]::SetEnvironmentVariable("Path", "$existingPath;$smlInstallerPath", "User")

Set-Location -Path $smlInstallerPath
Write-Host "Samoral Lang installed successfully."
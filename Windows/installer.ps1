$SML_ISNTALLER_PATH = "$env:USERPROFILE\Samora"
$SML_TEMP_INSTALLER_PATH =  "$env:TEMP\Samora" 

Write-Host "Retrieving Samora Lang release information ..."

$LATEST_SML_RELEASES = Invoke-WebRequest -Uri "https://api.github.com/repos/GraHms/Samora-Lang/releases/latest" | ConvertFrom-Json
$LATEST_TAG = $LATEST_SML_RELEASES.tag_name

Write-Host "Samora Lang latest version: $LATEST_TAG"

$SML_ASSETS = $LATEST_SML_RELEASES.assets

foreach ($ASSET in $SML_ASSETS) {
    if ($ASSET.name.ToLower().Contains("WINDOWS".ToLower())) {
        $ASSET_DOWNLOAD_LINK = $ASSET.browser_download_url
        Write-Host "Windows installer: $ASSET_DOWNLOAD_LINK"
        Invoke-WebRequest -Uri $ASSET_DOWNLOAD_LINK -OutFile $SML_TEMP_INSTALLER_PATH
        break
    }
}

if (Test-Path "$SML_ISNTALLER_PATH") {
    Write-Host "Samora Lang executable found under $SML_ISNTALLER_PATH"
    Write-Host "Removing Samoral Lang under $SML_ISNTALLER_PATH"

    Remove-Item -Path "$SML_ISNTALLER_PATH" -Recurse -Force

    Write-Host "Deletion complete $SML_ISNTALLER_PATH"
}

Start-Sleep -Seconds 5

New-Item -Path "$SML_ISNTALLER_PATH" -ItemType Directory

Write-Host "Extracting sml compiler and initializing installation"
tar -xzf $SML_TEMP_INSTALLER_PATH

Move-Item -Path "samora-lang.exe" -Destination "$SML_ISNTALLER_PATH/samora.exe" 
Move-Item -Path "README.md" -Destination "$SML_ISNTALLER_PATH/README.md" 

Start-Sleep -Seconds 5

Write-Host "Setting environment variables for SML compiler"
$HOST_ENV_VARS = [Environment]::GetEnvironmentVariable("Path", "User")

[Environment]::SetEnvironmentVariable("Path", "$HOST_ENV_VARS;$SML_ISNTALLER_PATH", "User")

Start-Sleep -Seconds 5

Write-Host "Samora Lang installation completed successfully..."

Write-Host "Compiler: $SML_ISNTALLER_PATH/samora.exe"
Write-Host "Readme: $SML_ISNTALLER_PATH/README.md"

Write-Host "Enjoy :) !!!"
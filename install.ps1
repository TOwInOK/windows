# Установка используемого протокола безопасности для скачивания
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Установка Visual Studio Build Tools
$vsBuildToolsUrl = "https://aka.ms/vs/17/release/vs_BuildTools.exe"
$vsBuildToolsFileName = "vs_BuildTools.exe"
Write-Host "Downloading Visual Studio Build Tools..."
Invoke-WebRequest -Uri $vsBuildToolsUrl -OutFile $vsBuildToolsFileName
Write-Host "Installing Visual Studio Build Tools..."
Start-Process -FilePath $vsBuildToolsFileName -ArgumentList "--quiet", "--norestart", "--wait", "--includeRecommended" -Wait

# Скачивание и установка NVIDIA драйвера
$nvidiaDriverUrl = "https://www.nvidia.com/content/DriverDownloads/confirmation.php?url=%2FWindows%2F556.12%2F556.12-desktop-win10-win11-64bit-international-dch-whql.exe&lang=ru&type=GeForce"
$nvidiaDriverFileName = "556.12-desktop-win10-win11-64bit-international-dch-whql.exe"
Write-Host "Downloading NVIDIA Driver..."
Invoke-WebRequest -Uri $nvidiaDriverUrl -OutFile $nvidiaDriverFileName
Write-Host "Installing NVIDIA Driver..."
Start-Process -FilePath $nvidiaDriverFileName -ArgumentList "-silent" -Wait

# Изменение политики выполнения скриптов
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Установка Scoop
Write-Host "Installing Scoop..."
Invoke-RestMethod -Uri 'https://get.scoop.sh' -UseBasicParsing | Invoke-Expression

# Добавление репозиториев Scoop
scoop bucket add main
scoop bucket add extras

# Установка приложений через Scoop
$apps = "rust", "firefox", "vscode", "spotify", "pipx", "nu", "wget", "git", "7zip", "steam", "sharex", "msiafterburner", "pia-desktop", "alacritty", "nodejs"
$apps | ForEach-Object {
    Write-Host "Installing $_..."
    Start-Process powershell -ArgumentList "scoop install $_" -Wait
}

# Установка Python пакетов через pipx
$pipxApps = "poetry", "ruff", "ruff-lsp"
$pipxApps | ForEach-Object {
    Write-Host "Installing $_ via pipx..."
    Start-Process powershell -ArgumentList "pipx install $_" -Wait
}

Write-Host "Installation Complete."
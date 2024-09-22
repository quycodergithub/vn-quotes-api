# Kiểm tra quyền admin
function Test-Administrator {
    $currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "Bạn cần chạy PowerShell với quyền admin. Đang yêu cầu quyền..."
    Start-Process powershell "-File $PSCommandPath" -Verb RunAs
    Exit
}

# Kiểm tra phiên bản Windows
$windowsVersion = (Get-WmiObject -Class Win32_OperatingSystem).Version

# Cài Scoop nếu chưa có
if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Host "Đang cài đặt Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

# Tùy chọn theo phiên bản Windows
if ($windowsVersion -like "10.*" -or $windowsVersion -like "11.*") {
    Write-Host "Phát hiện Windows 10/11."

    # Cài Python bằng Scoop
    scoop install python

    # Tạo script mẫu cho người dùng
    $scriptContent = @"
import requests

def get_quote():
    response = requests.get('https://api.quotable.io/random')
    if response.status_code == 200:
        data = response.json()
        return data['content'] + " - " + data['author']
    return None

print(get_quote())
"@

    # Lưu script vào file
    $scriptPath = "$HOME\Desktop\quote_script.py"
    $scriptContent | Set-Content -Path $scriptPath

    Write-Host "Script đã được lưu vào Desktop tại: $scriptPath"
}
elseif ($windowsVersion -like "6.1.*" -or $windowsVersion -like "6.2.*" -or $windowsVersion -like "6.3.*") {
    Write-Host "Phát hiện Windows 7/8."

    # Tải và cài PuTTY
    $puttyUrl = "https://the.earth.li/~sgtatham/putty/latest/w64/putty.exe"
    $puttyPath = "$HOME\Downloads\putty.exe"
    Invoke-WebRequest -Uri $puttyUrl -OutFile $puttyPath
    Write-Host "PuTTY đã được tải xuống: $puttyPath"

    # Tải và cài Python thủ công
    $pythonUrl = "https://www.python.org/ftp/python/3.9.9/python-3.9.9-amd64.exe"
    $pythonPath = "$HOME\Downloads\python-3.9.9-amd64.exe"
    Invoke-WebRequest -Uri $pythonUrl -OutFile $pythonPath
    Write-Host "Python đã được tải xuống: $pythonPath"

    Write-Host "Vui lòng cài đặt PuTTY và Python thủ công."
}

# Cài đặt các yêu cầu từ tệp requirements.txt nếu có
if (Test-Path "$PSScriptRoot\requirements.txt") {
    Write-Host "Đang cài đặt các package từ requirements.txt..."
    pip install -r "$PSScriptRoot\requirements.txt"
} else {
    Write-Host "Không tìm thấy tệp requirements.txt."
}

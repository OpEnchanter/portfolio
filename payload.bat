@echo off
title Rick Roll
echo Downloading special content...

:: Create a temporary directory
mkdir "%TEMP%\rickroll" 2>nul
cd /d "%TEMP%\rickroll"

:: Download the video using PowerShell
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/PYer-Sam/rickroll/raw/master/rickroll.mp4', 'rickroll.mp4')"

:: Check if the download was successful
if not exist "rickroll.mp4" (
    echo Download failed. Trying alternative source...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://archive.org/download/rick-astley-never-gonna-give-you-up/Rick%20Astley%20-%20Never%20Gonna%20Give%20You%20Up.mp4', 'rickroll.mp4')"
)

:: Play the video in the background using Windows Media Player
if exist "rickroll.mp4" (
    start /min "" wmplayer "rickroll.mp4" /play /close
    echo Enjoy your special content!
) else (
    echo Failed to download the video.
)

:: Optional: Self-delete this batch file
:: (uncomment the next line if you want the batch file to delete itself after running)
:: (cd /d "%~dp0" && del "%~nx0")

exit
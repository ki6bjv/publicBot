param (
    [Parameter(Mandatory = $true)]
    [string]$room,

    [Parameter(Mandatory = $true)]
    [string]$text
)

. "$PSScriptRoot\Env.ps1"


$apiKey = $pushCutKey
$notificationName = $room  # Change this to match your Pushcut notification


$body = @{
    text = "$text"
} | ConvertTo-Json -Depth 2

$response = Invoke-RestMethod `
    -Method Post `
    -Uri "https://api.pushcut.io/v1/notifications/$notificationName" `
    -Headers @{
        "API-Key" = $apiKey
        "Content-Type" = "application/json"
    } `
    -Body $body

Write-Output "Notification sent: $($response | Out-String)"


param (
    [string]$text,
    [string]$room
)

$apiKey = $env:PUSHCUT_API_KEY
$notificationName = "MacAlert"  # Change this to match your Pushcut notification

if (-not $apiKey) {
    Write-Error "PUSHCUT_API_KEY is not set in environment variables."
    exit 1
}

$body = @{
    text = "$text (Room: $room)"
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


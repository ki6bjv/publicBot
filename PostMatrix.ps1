#!/usr/bin/env pwsh

param (
    [Parameter(Mandatory=$true)][string]$message,
    [Parameter(Mandatory=$true)][string]$room
)

. "$PSScriptRoot\Env.ps1"

$pw_plain = $matrixkey

Switch -Exact ($room)
{   
    hampi {$m_room="!RgOheexjomFaILdvGA:ki6bjv.tech"}
    hook {$m_room="!ImcsAkEpNmEhAGjdRa:ki6bjv.tech"}    
    notify {$m_room="!TwSqZMrCWvpGNaWfmc:ki6bjv.tech"}
    work {$m_room="!GYmNOlsPsTshLXWvpE:ki6bjv.tech"}
}

$url = 'https://matrix.ki6bjv.tech/_matrix/client/r0/rooms/' + $m_room + '/send/m.room.message'
$body = @{
    body = $message;
    msgtype = "m.text"
}
$header = @{
    'Authorization' = 'Bearer ' + $pw_Plain
}

Invoke-RestMethod -Uri $url -Method Post -Headers $header -Body ($body|ConvertTo-Json)

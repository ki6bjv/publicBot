# deploy.ps1

# Configuration
$containerName = "bot"
$imageName     = "bot"
$volumeMap     = "$PWD/:/home/ki6bjv/bot"
$portMap       = "443:9000"
$restartPolicy = "unless-stopped"

# 1. Stop running container
$running = docker ps -q -f "name=^${containerName}$"
if ($running) {
    Write-Host "Stopping running container '$containerName'..."
    docker stop $containerName | Out-Null
}

# 2. Remove any existing container
$exists = docker ps -aq -f "name=^${containerName}$"
if ($exists) {
    Write-Host "Removing existing container '$containerName'..."
    docker rm $containerName | Out-Null
}

# 3. Remove existing image
$imageId = docker images -q $imageName
if ($imageId) {
    Write-Host "Removing existing image '$imageName'..."
    docker rmi -f $imageName | Out-Null
}

# 4. Build the image
Write-Host "Building image '$imageName'..."
docker build -t $imageName . | Write-Host

# 5. Run the container
Write-Host "Starting container '$containerName'..."
docker run -d `
    --name $containerName `
    --restart $restartPolicy `
    -v $volumeMap `
    -p $portMap `
    $imageName | Write-Host


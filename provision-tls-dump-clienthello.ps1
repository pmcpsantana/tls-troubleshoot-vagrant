Add-Type -AssemblyName System.IO.Compression.FileSystem
function Install-ZippedApplication($destinationPath, $name, $url, $expectedHash, $expectedHashAlgorithm='SHA256') {
    $localZipPath = "$env:TEMP\$name.zip"
    (New-Object System.Net.WebClient).DownloadFile($url, $localZipPath)
    $actualHash = (Get-FileHash $localZipPath -Algorithm $expectedHashAlgorithm).Hash
    if ($actualHash -ne $expectedHash) {
        throw "$name downloaded from $url to $localZipPath has $actualHash hash that does not match the expected $expectedHash"
    }
    [IO.Compression.ZipFile]::ExtractToDirectory($localZipPath, $destinationPath)
    Remove-Item $localZipPath
}

$tlsDumpClientHelloHome = "$env:USERPROFILE\Desktop\tls-dump-clienthello"

function Install-TlsDumpClientHello {
    Install-ZippedApplication `
        $tlsDumpClientHelloHome `
        tls-dump-clienthello `
        https://github.com/rgl/tls-dump-clienthello/releases/download/v1.4/tls-dump-clienthello.zip `
        b5cd14b149b865a3bf5c32a675cbab110bd3ec88c8190889af37b21b3f54da4c
}

Install-TlsDumpClientHello

Add-Content -Encoding Ascii -Path "$env:WINDIR\System32\drivers\etc\hosts" "127.0.0.1 example.com`n"
Import-Certificate `
    -FilePath "$tlsDumpClientHelloHome\example.com-crt.pem" `
    -CertStoreLocation Cert:LocalMachine\Root `
    | Out-Null

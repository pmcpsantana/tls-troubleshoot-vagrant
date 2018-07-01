choco install -y wireshark

# leave npcap on the desktop for the user to install manually.
# (it does not has a silent installer).
$url = 'https://nmap.org/npcap/dist/npcap-0.99-r6.exe'
$expectedHash = '0ec295eb654f0626a1cc54a605fdf93ba043a20ae3c2b6f02fbca7e86a51cd82'
$localPath = "$env:USERPROFILE\Desktop\$(Split-Path -Leaf $url)"
(New-Object Net.WebClient).DownloadFile($url, $localPath)
$actualHash = (Get-FileHash $localPath -Algorithm SHA256).Hash
if ($actualHash -ne $expectedHash) {
    throw "downloaded file from $url to $localPath has $actualHash hash that does not match the expected $expectedHash"
}

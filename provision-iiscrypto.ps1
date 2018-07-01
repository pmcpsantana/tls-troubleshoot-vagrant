choco install -y iiscrypto-cli iiscrypto

Write-Output 'Applying the wireshark schannel settings (only the RSA key-exchange is enabled)...'
IISCryptoCli /template schannel-wireshark.ictpl
if ($LASTEXITCODE) {
    throw "failed to apply schannel settings. exit code $LASTEXITCODE."
}

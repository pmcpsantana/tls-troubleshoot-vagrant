Vagrant.configure(2) do |config|
  config.vm.box = "windows-2016-amd64"
  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
    vb.memory = 2*1024
    vb.customize ["modifyvm", :id, "--vram", 32]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end
  config.vm.provision "shell", path: "ps.ps1", args: "provision-choco.ps1"
  config.vm.provision "shell", path: "ps.ps1", args: "provision.ps1"
  config.vm.provision "shell", path: "ps.ps1", args: "provision-iiscrypto.ps1"
  config.vm.provision "reload"
  config.vm.provision "shell", path: "ps.ps1", args: "provision-tls-dump-clienthello.ps1"
  config.vm.provision "shell", path: "ps.ps1", args: "provision-wireshark.ps1"
  config.vm.provision "shell", path: "ps.ps1", args: "provision-shortcuts.ps1"
end

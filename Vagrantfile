Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7"
  #config.vm.network "forwarded_port", guest: 8080, host: 8086
  ####### Provision #######
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "jenkins.yml"
    ansible.verbose = true
    ansible.raw_arguments  = " --vault-password-file=./vault_password.txt"
  end
end

#!/bin/bash
echo "Copying the github repos"
ansible-playbook git.yml
echo "#####################################"
echo "Copying the Ansible hostfile"
cp hostsbgpv4Local aviLsc/hosts
cp hostsbgpv4Local cs/hosts
cp hostsbgpv4Local aviBootstrap/hosts
cp hostsbgpv4Local aviLscCloud/hosts
cp hostsbgpv4Local vyos/hosts
echo "#####################################"
echo "Copying the config files"
cp params_aviLsc.yml aviLsc/vars/params.yml
cp params_aviBootstrap.yml aviBootstrap/vars/params.yml
cp vyos_bgpv4Local.conf vyos/config.conf
cp params_vyos.yml vyos/vars/params.yml
cp params_cs cs/vars/params.yml
cp params_aviLscCloud.yml aviLscCloud/vars/params.yml
echo "#####################################"
echo "Apply the configuration"
cd aviLsc
ansible-playbook -i hosts generateCreds.yml
cd ../vyos
ansible-playbook -i hosts vyos.yml
cd ../cs
ansible-playbook -i hosts main.yml
cd ../aviBootstrap
ansible-playbook -i hosts main.yml
cd ../aviLscCloud
ansible-playbook -i hosts main.yml

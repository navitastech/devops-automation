# Devops Automation

Repository for Navitas Labs Automation

## Setup

 Clone the Repo

```bash
git clone https://github.com/navitastech/devops-automation.git

cd devops-automation


```
Edit ansible.cfg first time to create automation user and ssh keys to all servers
```
#remote_user=cicduser
#private_key_file = ~/.ssh/id_rsa
remote_user=root
ask_pass=true
```
run the below playbook . This will create user "cicduser"  along with ssh keys on all the servers listed in inventory file
```
./provision.sh devops-user
````
## Jenkins Setup

```
./provision.sh jenkins
````

## Nexus Setup

```
./provision.sh nexus
````

## Keyclaok Setup

```
./provision.sh keycloak
````
 
## Openshift Origin Setup

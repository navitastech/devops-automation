# Devops Automation

Repository for Navitas Labs Automation

## Tools Inventory
| IP Address  | Machine Name | DNS Name | 
| ------------- | ------------- |------------- |
| 192.168.2.160 |  bhost.navitaslab.com |   |
| 192.168.2.171 |  bdns.navitaslab.com |  | 
| 192.168.2.172 |  jenkins.navitaslab.com | jenkins.navitas-labs.com |  
| 192.168.2.173 |  keycloak.navitaslab.com | keycloak.navitas-labs.com | 
| 192.168.2.150 |  nexus.navitaslab.com |  nexus.navitas-labs.com | 
| 192.168.2.177 |  mysql.navitaslab.com |  |
| 192.168.2.178 |  postgres.navitaslab.com |  |

## Openshift Origin Inventory
| IP Address  | Machine Name | DNS Name | 
| ------------- | ------------- |------------- |
| 192.168.2.174 | okd-master.navitaslabs.com  |  okd-master.navitaslabs.com |
| 192.168.2.175 |  okd.worker1.navitaslabs.com |  |
| 192.168.2.176 | okd.worker2.navitaslabs.com |  |

## Kubernetes HA Inventory
| IP Address  | Machine Name | DNS Name | 
| ------------- | ------------- |------------- |
| 192.168.2.161	| k8s-master1.navitaslabs.com |    |
| 192.168.2.162	| k8s-master2.navitaslabs.com |   | 
| 192.168.2.163 | k8s-master3.navitaslabs.com |   | 
| 192.168.2.164 | etcd1.navitaslabs.com  |  |  
| 192.168.2.165	| etcd2.navitaslabs.com |  |  
| 192.168.2.166 | etcd3.navitaslabs.com |   | 
| 192.168.2.167	| worker1.navitaslab.com |   | 
| 192.168.2.168	| worker2.navitaslab.com |   | 
| 192.168.2.169 | worker3.navitaslab.com |   | 
| 192.168.2.170 | worker4.navitaslab.com |   | 

## Kubernetes Tools Cluster Inventory
| IP Address  | Machine Name | DNS Name | 
| ------------- | ------------- |------------- |
| 192.168.2.181	| k8s-tools-master.navitaslabs.com |    |
| 192.168.2.182	| k8s-tools-worker1.navitaslabs.com |   | 
| 192.168.2.183 | k8s-tools-worker2.navitaslabs.com |   | 

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

### Step 1
```
git clone https://github.com/openshift/openshift-ansible
cd openshift-ansible
pip install -r requirements.txt

```
### Step 2
Preprare the hosts file(inventory/hosts)
```


[masters]
okd-master.navitaslabs.com

[etcd]
okd-master.navitaslabs.com

[nodes]
okd-master.navitaslabs.com openshift_node_group_name="node-config-master-infra"
okd.worker1.navitaslabs.com openshift_node_group_name="node-config-compute"
okd.worker2.navitaslabs.com openshift_node_group_name="node-config-compute"

[nfs]
okd-master.navitaslabs.com
 
# Create an OSEv3 group that contains the masters and nodes groups
[OSEv3:children]
masters
nodes
etcd
 
[OSEv3:vars]
ansible_user=cicduser

ansible_become=yes
openshift_version="3.11"
openshift_release="3.11"
openshift_deployment_type=origin
openshift_image_tag="v3.11.0"
openshift_master_bootstrap_enabled=True
 
openshift_pkg_version=-3.11.0
openshift_master_default_subdomain=apps.okd.navitas-labs.com
 

 
# Debug level for all OpenShift components (Defaults to 2)
debug_level=2

openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider'}]
# Defining htpasswd users
openshift_master_htpasswd_users={'admin': '$apr1$9Ip8p9sY$8vVQLVN9JiVXCuQylKZeC.', 'admin2': '$apr1$9Ip8p9sY$8vVQLVN9JiVXCuQylKZeC.'}
 
```

### Step 3
```
ansible-playbook -i inventory/hosts playbooks/prerequisites.yml
ansible-playbook -i inventory/hosts playbooks/deploy_cluster.yml
```
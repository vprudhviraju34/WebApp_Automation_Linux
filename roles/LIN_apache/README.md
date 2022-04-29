Role Name
=========
Download and Install Apache

Requirements
------------
No special requirements; note that this role requires root access,


Tested on Operating System
--------------------------
SUSE-12-SP-5 & RHEL

Role Variables
--------------

* NOTE: The Variable Name that are marked as Variable Type=Parameter has to be passed by vRA/SNOW.

| Variable Name | Default Value | Internal/Parameter | Comments |
|---------------|---------------|-----------------|----------------|
| apache_src | /appl/source/apache.tar.gz | Parameter | This variable need to be updated in the defaults/main.yml file |

* Note: The variables that are of "Variable Type=Parameter" they are needed to be passed in form of EXTRA-VARS in TOWER REST API calls or in the EXTRA-VARIABLES section ANSIBLE TOWER >> TEMPLATES >> EXTRA-VARIABLES
* Note: the "myhost" variable should be passed as list in the EXTRA-VARS section on the Anisble Tower under Template. For example as below:
```
---
myhost:
  - TDAC00000xxx.cqcorp.daimler.net
  - TDAC00000xxx.cqcorp.daimler.net
```

Pre-requisties
--------------

* All the Binaries should be available on /home/webadm/_Source/apache.tar.gz

Launching Job Template using Tower REST API
------------------------------------------
* Use the following REST API call to launch the Ansible Tower Job Template from anywhere. This will connect the Ansible Tower from any where as far as the tower username/password has been provided in the following curl command.
```
curl -X POST --user <TOWER_USERNAME>:<TOWER_PASSWORED> -d '{"extra_vars": "{\"myhost\": \"[TDAC00000xxx.cqcorp.daimler.net]\"}"}' -H "Content-Type: application/json" https://<TOWER FQDN>>/api/v1/job_templates/<JOB_TEMPLATE_ID>/launch/ -k
```
* Sample values for the feild that are used in above curl command
    * TOWER_USERNAME: admin
    * TOWER_PASSWORD: P@ssw0rd
    * TOWER_FQDN: Can be IP Address or Fully Qualified Domain Name: TDAC00000xxx.cqcorp.daimler.com
    * JOB_TEMPLATE_ID: Pre-requisite to obtain this is : Job Template with some Job Template name should already exists with Project, Credentials, Inventory attached to it. Use the following curl to fetch the Job ID by giving the JOB_TEMPLATE_NAME=MW_COMPONENT_JOB. For example:
```
curl -X GET --user admin:ansiblerocks https://tower.example.com/api/v1/job_templates/?name="MW_COMPONENT_JOB" -k -s | json_pp
```
Output of above command:
```
{
   "previous" : null,
   "results" : [
      {
         "ask_variables_on_launch" : false,
         "next_job_run" : null,
         "id" : 10,
```
* All the extra variable that are to be passed should be under : "extra_vars" json payload.

Steps to Run the playbook
--------------------------
Git clone the repo from Application branch of Automation Repository.

Update the roles/ansible-role-suse-apache/defaults/main.yml with the variables

Run the command to setup apache
#ansible-playbook apache-setup.yml


License
-------

MIT/ BSD
Diamler

Author Information
------------------

This role was created by ITT APAC Webapp team

Support
-------

In case of support - please contact Webapp team at 


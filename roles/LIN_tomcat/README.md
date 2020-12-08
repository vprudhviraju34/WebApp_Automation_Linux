Role Name
=========

Installs and configures Tomcat server on SUSE & RHEL Servers.

Requirements
------------

No special requirements; note that this role requires root access,

Tested on Operating System
--------------------------

SUSE-12-SP-5 & RHEL
Tested Version of Tomcat: tomcat - 9.0.40
Java Version: java-1.8.0-openjdk

Role Variables
--------------

* NOTE: The Variable Name that are marked as Variable Type=Parameter has to be passed by vRA/SNOW.

| Variable Name | Default Values | Variable Type | Comments |
|------------------------|---------------------------|---------------------------|------------------------------|
| myhost | TDAC00000943.cqcorp.daimler.net | Parameter | DataType=LIST Need to passed by vRA/SNOW in form of EXTRA-VARS on Ansible Tower. It can be IP Address or FQDN |
| tomcat_package | tomcat.tar.gz | Parameter | Binary Filename: To be passed by vRA/SNOW |
| tomcat_version | 9.0.40 | Paramter | Needs to be passed by vRA/SNOW as EXTRA-VARS on Ansible Tower |


* Note: The variables that are of "Variable Type=Parameter" they are needed to be passed in form of EXTRA-VARS in TOWER REST API calls or in the EXTRA-VARIABLES section ANSIBLE TOWER >> TEMPLATES >> EXTRA-VARIABLES
* Note: the "myhost" variable should be passed as list in the EXTRA-VARS section on the Anisble Tower under Template. For example as below:
```
---
myhost:
  - TDAC00000943.cqcorp.daimler.net
  - TDAC00000944.cqcorp.daimler.net
```

Pre-requisties
--------------

* All the Binaries should be available in the agreed file system and accordingly the changes should be done in the variables list above to point to appropriate directory.

Dependencies
------------
* All the relevant file system should be created for installation.
* There should be sufficient space on the file system or the mount point where you want to install the software.
* This playbook requires one zip/tar file for the installation.

Launching Job Template using Tower REST API
------------------------------------------
* Use the following REST API call to launch the Ansible Tower Job Template from anywhere. This will connect the Ansible Tower from any where as far as the tower username/password has been provided in the following curl command.
```
curl -X POST --user <TOWER_USERNAME>:<TOWER_PASSWORED> -d '{"extra_vars": "{\"myhost\": \"[TDAC00000943.cqcorp.daimler.net]\",\"tomcat_version\":\"8.5.14\"}"}' -H "Content-Type: application/json" https://<TOWER FQDN>>/api/v1/job_templates/<JOB_TEMPLATE_ID>/launch/ -k
```
* Sample values for the feild that are used in above curl command
    * TOWER_USERNAME: admin
    * TOWER_PASSWORD: P@ssw0rd
    * TOWER_FQDN: Can be IP Address or Fully Qualified Domain Name: TDAC00000943.cqcorp.daimler.com
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


Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
        - ansible-role-suse-tomcat

License
-------

MIT/ BSD
Diamler

Author Information
------------------

This role was created by ITT APAC Webapp team

Support
-------

In case of support - please contact Webapp team at dwa_128-iti_webappteam_npm-editor@daimler.com

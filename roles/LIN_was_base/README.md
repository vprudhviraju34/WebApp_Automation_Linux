Role Name
=========

Installs and configures IBM WAS server on SUSE Servers.
This Role and Playbook will install IBM-WAS 8.x.x or 9.x.x

Requirements
------------
This role requires root access

Tested on Operating System
--------------------------

SUSE-12-SP-3

Role Variables
--------------
* NOTE: The Variable Name that are marked as Variable Type=Parameter has to be passed by vRA/SNOW.

| Variable Name | Default Values | Variable Type | Comments |
|------------------------|---------------------------|---------------------------|------------------------------|
| myhost | TDAC00000943 | Parameter | Need to passed by vRA/SNOW in form of EXTRA-VARS Ansible Tower. It can be IP Address or FQDN |
| agent_installer | agent.installer.lnx.gtk.x86_64_1.8.5.zip | Parameter/Internal | It is file name which can change based on the WAS software Binaries. Daimler to decide whether it will be Parameter/Internal |
| ibm_was_installer | was.repo.9000.base.zip | Parameter/Internal | It is file name. IBM-WAS installer it can be 8.X.X or 9.x.x version of IBM-WAS. Daimler to decide whether it will be Parameter/Internal |
| java_sdk | sdk.repo.8030.java8.linux.zip | Parameter/Internal | It is file name. JAVA sdk binary. Daimler to decide whether it should be Parameter/Internal |
| ibm_was_installer_fp | 9.0.0-WS-WAS-FP011.zip | Parameter | Need to pass by vRA/SNOW. This is the IBM FixPack software which IBM releases periodically |

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
* IBM-WAS product comes with 3 zip file which IBM releases. This playbook requires on zip file for the installation. Therefore, all the 3 zip files are needed to consolidated to one ZIP file - so that playbook can operate on.
For example: These three file needs to consolidated into 1 zip file

  WAS_8.5_Repo_BASE_1_OF_3.zip |
  WAS_8.5_Repo_BASE_2_OF_3.zip | ==> WAS_8.5_Repo_BASE.zip
  WAS_8.5_Repo_BASE_3_OF_3.zip |

Launching Job Template using Tower REST API
------------------------------------------
* Use the following REST API call to launch the Ansible Tower Job Template from anywhere. This will connect the Ansible Tower from any where as far as the tower username/password has been provided in the following curl command.
```
curl -X POST --user <TOWER_USERNAME>:<TOWER_PASSWORED> -d '{"extra_vars": "{\"myhost\": \"[TDAC00000943.cqcorp.daimler.net]\"}"}' -H "Content-Type: application/json" https://<TOWER FQDN>>/api/v1/job_templates/<JOB_TEMPLATE_ID>/launch/ -k
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

    - name: Register Host Dynamic Inventory
      hosts: localhost
      gather_facts: no
      tasks:
        - name: Adding hosts
          add_host:
            hostname: "{{item}}"
            groupname: myhosts
          with_items: "{{myhost}}"

    - hosts: myhosts
      become: true
      roles:
        - ansible-role-suse-was

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


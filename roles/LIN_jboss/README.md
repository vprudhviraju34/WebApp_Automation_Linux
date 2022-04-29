Role Name
=========

Installs and configures JBOSS on SUSE & RHEL Servers.

Requirements
------------

No special requirements; note that this role requires root access,

Tested on Operating System
--------------------------

SUSE-12-SP-5 & RHEL
Jboss Version: jboss-eap-7.3.0

Role Variables
--------------

* NOTE: The Variable Name that are marked as Variable Type=Parameter has to be passed by vRA/SNOW.

| Variable Name | Default Values | Variable Type | Comments |
|------------------------|---------------------------|---------------------------|------------------------------|
| myhost |  | Parameter | Need to passed by vRA/SNOW in form of EXTRA-VARS on Ansible Tower. It can be IP Address or FQDN |
| jboss_installer | jboss-eap-7.3.0.zip | Parameter/Internal | Binary Filename: If the version changes then pass the new name of the filename and change the 'jboss_base_version' accordingly |
| jboss_base_version | 7.3 | Parameter/Internal | Change the version by looking at the source file of jboss e.g if jboss-eap-7.0.0.zip file is source then 7.0 is the base version |
| java_home | /usr/lib64/jvm/jre-1.8.0-openjdk | Internal | Change according to the environment |

* Note: The variables that are of "Variable Type=Parameter" they are needed to be passed in form of EXTRA-VARS in TOWER REST API calls or in the EXTRA-VARIABLES section ANSIBLE TOWER >> TEMPLATES >> EXTRA-VARIABLES
* Note: the "myhost" variable should be passed as list in the EXTRA-VARS section on the Anisble Tower under Template. For example as below:
```
---
myhost:
  - .cqcorp..net
  - .cqcorp..net
```

Pre-requisties
--------------

* All the Binaries should be available in the agreed file system and accordingly the changes should be done in the variables list above to point to appropriate directory.

Dependencies
------------
* All the relevant file system should be created for installation.
* There should be sufficient space on the file system or the mount point where you want to install the software.
* This playbook requires one zip file for the installation. Therefore, all the 3 zip files are needed to consolidated to one ZIP file - so that playbook can operate on.
For example: These three file needs to consolidated into 1 zip file

  jboss-eap_1_OF_3.zip |
  jboss-eap_2_OF_3.zip | ==> jboss-eap-7.3.0.zip
  jboss-eap_3_OF_3.zip |

Launching Job Template using Tower REST API
------------------------------------------
* Use the following REST API call to launch the Ansible Tower Job Template from anywhere. This will connect the Ansible Tower from any where as far as the tower username/password has been provided in the following curl command.
```
curl -X POST --user <TOWER_USERNAME>:<TOWER_PASSWORED> -d '{"extra_vars": "{\"myhost\": \"[.cqcorp..net]\"}"}' -H "Content-Type: application/json" https://<TOWER FQDN>>/api/v1/job_templates/<JOB_TEMPLATE_ID>/launch/ -k
```
* Sample values for the feild that are used in above curl command
    * TOWER_USERNAME: admin
    * TOWER_PASSWORD: P@ssw0rd
    * TOWER_FQDN: Can be IP Address or Fully Qualified Domain Name: .cqcorp..com
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

      - name: Register Host to Dynamic Inventory
        hosts: localhost
        gather_facts: yes
        tasks:
          - name: Adding hosts
            add_host:
              hostname: "{{item}}"
              groupname: myhosts
            with_items: "{{myhost}}"

      - hosts: myhosts
        become: true
        roles:
          - ansible-role-suse-jboss

License
-------

MIT/ BSD


Author Information
------------------

This role was created by ITT APAC Webapp team

Support
-------

In case of support - please contact Webapp team at 


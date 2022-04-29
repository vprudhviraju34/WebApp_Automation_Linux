# WebApp Components Installation 

## Purpose of Playbook
> It is used for an End-to-End Installation and Configuration of Application on an existing server

Requirements
------------
>- Server should be Reachable and Managed from Ansible Tower

Tested on Operating System
--------------------------
>- SLES 12 - SP4 and SP5
>- RHEL - 7.7 and higher

## Team Members
>- PB WebApp team


## Steps Performed via Application Installation & Configuration
>- Check for the Application Filesystem present on Server
>- Check for the respective component binaries present on source FileSystem
>- Create Application specific user accounts and groups
>- Install Application as per User Inputs
>- Perform Application Configuration post successful installation
>- Remove binaries from source path

## Applications Supported
>- Apache Web Server
>- Apache Tomcat
>- Websphere
>- Websphere - Network Deployment
>- IBM HTTP Web Server, Plugins & WCT
>- JBoss Application Server


## Variables needed for ServerBuild Jobs

Playbook Variables
------------------

| Variable Name | Default Value | Internal/Parameter | Comments |
|---------------|---------------|--------------------|----------------|
| myhost | | Parameter | This variable will have details of Target Server(in lowercase) to be connected |
| application |  | Parameter | This variable will have the application to be installed which will be passed as a extra variable  |


## Sample Variables: Tomcat Installation
```
application: LIN_tomcat
myhost:
  - 53.196.xx.xx

```

Dependencies
------------
* Target host should be reachable and managed from Ansible host

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: all
      roles:
        - LIN_apache
        - LIN_tomcat
        - LIN_was_base
        - LIN_was_nd
        - LIN_ibm_http
        - LIN_jboss
       

License
-------

MIT/ BSD
D

Author Information
------------------

This role was created by ITT APAC Webapp team

Support
-------

In case of support - please contact Webapp team at 

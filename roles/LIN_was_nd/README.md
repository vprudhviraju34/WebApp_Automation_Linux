
# ansible-role-suse-ibm-wasnd-cluster

Ansible playbook for IBM WebSphere Application Server installation and two nodes cluster setup

# Playbook

| Playbook name      | Description                                                           |
| ------------------ | --------------------------------------------------------------------- |
| playbook-wasnd.yml | Install IBM WebSphere Application Server - Network Deployment - 9.0.5 |

# Roles

| Role name          | Description of Role                                                   |
| -------------------| --------------------------------------------------------------------- |
| ansible-role-suse-ibm-wasnd-cluster | Install IBM Installation Manager                     |
                     | Install IBM WebSphere Application Server - Network Deployment - 9.0.5 |
                     | Create a profile for Deployment Manager                               |
                     | Create profiles for WAS Servers                                       |
                     | Federate Nodes with Dmgr                                              |
                     | Setup cluster                                                         |

# Variables

| Variable name      | Description                                                           |
| ------------------ | --------------------------------------------------------------------- |
| was_path           | Path where to install WAS                                             |
| iim_path           | Path where to install IIM                                             |
| was_tmp            | Place holder for installation logs and temp directory                 |
| was_user & was_grp | wasadm and wasgrp used as user and group                              |
| was-mode           | Default directory mode (default: 0750)                                |
| iim_src_file, was_src_file| IIM and WASND binary                                           |
| was_src_file_fp    | 9.0.0-WS-WAS-FP011.zip                                                |


# Getting start

## Prerequisites

1; Download installation files:

* IBM Installation Manager (agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip)
* IBM WebSphere Application Server 8.5.5 (WASND_v8.5.5_Binaries.zip)

2; Copy files to target nodes /tmp/IBM_was directory

3; Host fqdn must be resolveable or host entry must present in /etc/hosts file

Example of my repository

```

-- /tmp/IBM_was
    |-- agent.installer.linux.gtk.x86_64_1.8.5000.20160506_1125.zip
    |-- WASND_v8.5.5_Binaries.zip

```

## Configure Ansible hosts file

Change you ansible host file like **hosts**

## Cloning ansible-role-suse-ibm-wasnd from git

```

git clone <git_url>

```

## Running playbook

```

ansible-playbook --extra-vars='{"myhost": ['10.30.221.153', '10.30.221.154']}'  playbook-wasnd.yml

```

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

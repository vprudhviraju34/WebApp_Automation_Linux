#!/usr/bin/python
# -*- coding: utf-8 -*-

DOCUMENTATION = """
module: ibmim_installer
version_added: "1.0.0"
short_description: Installs IBM Installation Manager
description:
    - Install IBM Installation InstallationManager

options:
    src:
        required: false
        description: Path to installation files for Installation Manager
    dest:
        required: false
        default: "/appl/IBM/InstallationManager"
        description: Path to desired installation directory of IM
    logdir:
        required: false
        default: "/tmp"
        description: Path and file name of installation log file
    state:
        required: false
        choices: [present,absent]
        default: "present"
        description: Whether Installation Mangaer should be installed or removed
"""

import os
import subprocess
import platform
import datetime
import socket
import re

class InstallationManagerInstaller():
    module = None
    module_facts = dict(
        im_version = None,
        im_internal_version = None,
        im_arch = None,
        im_header = None
    )

    def __init__(self):
        self.module = AnsibleModule (
            argument_spec = dict(
                state  = dict(default='present', choices=['present']),
                src    = dict(required=False),
                dest   = dict(default="/appl/IBM/InstallationManager"),
                logdir = dict(default="/tmp")
            ),
            supports_check_mode=True
        )

    def isProvisioned(self, dest):
        """
		Checks if Installation Manager is already installed at dest
		:param dest: Installation directory of Installation Manager
		:return: True if already provisioned. False if not provisioned
		"""
		# If destination dir does not exists then its safe to assume that IM is not installed
        if not os.path.exists(dest):
            return False
        else:
            if "installed" in self.getVersion(dest)["im_header"]:
                return True
            return False


    def getVersion(self, dest):
        """
		Runs imcl with the version parameter and stores the output in a dict
		:param dest: Installation directory of Installation Manager
		:return: dict
		"""
        child =  subprocess.Popen(
            ["{0}/eclipse/tools/imcl version".format(dest)],
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout_value, stderr_value = child.communicate()

        try:
            self.module_facts["im_version"] = re.search("Version: ([0-9].*)", stdout_value).group(1)
            self.module_facts["im_internal_version"] = re.search("Internal Version: ([0-9].*)", stdout_value).group(1)
            self.module_facts["im_arch"] = re.search("Architecture: ([0-9].*-bit)", stdout_value).group(1)
            self.module_facts["im_header"] = re.search("Installation Manager.*",stdout_value).group(0)
        except AttributeError:
            pass

        return self.module_facts



    def main(self):
        state = self.module.params['state']
        src = self.module.params['src']
        dest = self.module.params['dest']
        logdir = self.module.params['logdir']

        if state == 'present':
            if self.module.check_mode:
                self.module.exit_json(changed=False, msg="IBM IM where to be installed at {0}".format(dest))

            # Check if IM is already installed
            if not self.isProvisioned(dest):
                #Check if path are valid
                if not os.path.exists(src+"/installc"):
                    self.module.fail_json(msg=src+"/installc not found")

                if not os.path.exists(logdir):
                    if not os.listdir(logdir):
                        os.mkdirs(logdir)

                logfile = "{0}_ibmim_{1}.xml".format(platform.node(), datetime.datetime.now().strftime("%Y%m%d-%H%M%S"))
                child = subprocess.Popen(
                    ["{0}/installc "
					 "-acceptLicense "
					 "-log {1}/{2} "
					 "-installationDirectory {3}".format(src, logdir, logfile, dest)],
					shell=True,
					stdout=subprocess.PIPE,
					stderr=subprocess.PIPE

                )
                stdout_value, stderr_value = child.communicate()
                if child.returncode != 0:
                    self.module.fail_json(
                        msg="IBM Installation Manager failed",
                        stderr=stderr_value,
                        stdout=stdout_value,
                        module_facts=self.module_facts
                    )
                #Module finished. Get version of the IM after installation so that it can be printed to user
                self.getVersion(dest)
                self.module.exit_json(
                    msg="IBM Installation Manager installed successfully",
                    stdout=stdout_value,
                    stderr=stderr_value,
                    changed=True,
                    module_facts=self.module_facts

                )

            else:
                self.module.exit_json(
                    changed=False,
                    msg="IBM IM is already installed",
                    module_facts=self.module_facts
                )

from ansible.module_utils.basic import *
if __name__ == '__main__':
    im = InstallationManagerInstaller()
    im.main()

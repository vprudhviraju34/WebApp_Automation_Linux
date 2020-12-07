#!/usr/bin/python
# -*- coding: utf-8 -*-

DOCUMENTATION = '''
---
module: ibmim
short_description: Manage IBM Installation Manager packages
description:
	- This module can Install, Uninstall and Update IBM Installation Manager packages on a supported Linux distribution.
	-	This module relies on 'imcl', the binary command line installed by the IM installer. You may use this module to install Installation Manager itself.
version_added: "1.9.4"
author: Amir Mofasser (@github)
requirements:
  - IBM Installation Manager
  - Installation files on remote server or local directory
options:
  id:
		description: The ID of the package which is to be installed
		aliases:
			- name
  ibmim:
		default: /appl/IBM/InstallationManager
		description: Path to installation directory of Installation Manager
  dest:
		description: Path to destination installation directory
  repositories:
		description: A list of repositories to use. May be a path, URL or both.
		type: list
		aliases:
			- repos
  state:
		choices:
			- present
			-	absent
			- latest
		default: present
		description: Install a package with 'present'. Uninstall a package with 'absent'. Update all packages with 'latest'.
  log:
		description: Specify a log file that records the result of Installation Manager operations.
'''

import os
import subprocess
import platform
import datetime
import shutil
import re

from ansible.module_utils.basic import AnsibleModule

class InstallationManager():

	module = None
	module_facts = dict(
		installed = False,
		version = None,
		id = None,
		path = None,
		name = None,
		stdout = None,
		stderr = None
	)

	def __init__(self):
		# Read arguments
		self.module = AnsibleModule(
			argument_spec = dict(

				# install
				state     									= dict(default='present', choices=['present']),

				# /appl/IBM/InstallationManager
				ibmim     									= dict(default='/appl/IBM/InstallationManager'),

				# Package ID
				id  												= dict(required=False, type='list', aliases=['name']),
                                was_id                                                                          = dict(required=False),

				# -installationDirectory
				dest      									= dict(required=False),

				# -repositories
				repositories 								= dict(required=False, type='list', aliases=['repos']),

				# -log
				log													= dict(required=False)

			),
			supports_check_mode = True
		)

	def getItem(self, key):
		return self.module_facts[key]


	def isProvisioned(self, dest, packageId):
		# If destination dir does not exists then its safe to assume that IM is not installed
		if dest:
			if not os.path.exists(dest):
				return False
		return self.getVersion(packageId)["installed"]


	def getVersion(self, packageId):

		child = subprocess.Popen(
			["{0}/eclipse/tools/imcl "
			 " listInstalledPackages "
			 " -long".format(self.module.params['ibmim'])],
			shell=True,
			stdout=subprocess.PIPE,
			stderr=subprocess.PIPE
		)

		stdout_value, stderr_value = child.communicate()

		# Store stdout and stderr
		self.module_facts["stdout"] = stdout_value
		self.module_facts["stderr"] = stderr_value

		if child.returncode != 0:
			self.module.fail_json(
				msg="Error getting installed version of package '{0}'".format(packageId),
				stdout=stdout_value
			)

		for line in stdout_value.split(os.linesep):
			if packageId in line:
				linesplit = line.split(" : ")
				self.module_facts["installed"] = True
				self.module_facts["path"] = linesplit[0]
				self.module_facts["id"] = linesplit[1]
				self.module_facts["name"] = linesplit[2]
				self.module_facts["version"] = linesplit[3]
				break

		return self.module_facts

	def install(self, module_params):

		# Check mode on
		if self.module.check_mode:
			self.module.exit_json(msg="Package '{0}' is to be installed".format(module_params['id']))

		# Check wether package is already installed
		if self.isProvisioned(module_params['dest'], module_params['was_id']):
			self.module.exit_json(changed=False, msg="Package '{0}' is already installed".format(module_params['was_id']), ansible_facts=self.module_facts)

		# Check if one of repositories and connectPassportAdvantage is provided
		if not module_params['repositories']:
			self.module.fail_json(msg="One or more repositories are required when installing packages")

		cmd = ("{0}/eclipse/tools/imcl install {1} "
						"-repositories {2} "
						"-acceptLicense "
						"-stopBlockingProcesses ").format(module_params['ibmim'], " ".join(module_params['id']), ",".join(module_params['repositories']))

		if module_params['dest']:
			cmd = "{0} -installationDirectory {1} ".format(cmd, module_params['dest'])
		if module_params['log']:
			cmd = "{0} -log {1} ".format(cmd, module_params['log'])

		child = subprocess.Popen(
			[cmd],
			shell=True,
			stdout=subprocess.PIPE,
			stderr=subprocess.PIPE
		)

		stdout_value, stderr_value = child.communicate()
		if child.returncode != 0:
			self.module.fail_json(
				msg="Failed installing package '{0}'".format(module_params['was_id']),
				stdout=stdout_value,
				stderr=stderr_value
		)

		# After install, get versionInfo so that we can show it to the user
		self.getVersion(module_params['was_id'])
		self.module.exit_json(changed=True, msg="Package '{0}' installed".format(module_params['was_id']), ansible_facts=self.module_facts)


	def main(self):

		# Check if paths are valid
		if not os.path.exists("{0}/eclipse".format(self.module.params['ibmim'])):
			self.module.fail_json(
				msg="IBM Installation Manager is not installed. Install it and try again.")

		# Install
		if self.module.params['state'] == 'present':
				self.install(self.module.params)

# import module snippets
if __name__ == '__main__':
	im = InstallationManager()
	im.main()

---
# Tasks file for ansible-role-suse-ibm-wasnd

- name: "Setup first node"
  include_tasks: setup_first_node.yml
  when: ansible_play_hosts.index(inventory_hostname) == 0

- name: "Setup second node"
  include_tasks: setup_second_node.yml
  when: ansible_play_hosts.index(inventory_hostname) == 1

- name: "Cleanup directories"
  include_tasks: cleanup.yml
# Ansible Starter

Scaffolding or structuring your Ansible projects mean that not only do you have a _sane_ way understanding how your projects are put together but you can also look at being able to re-use and extend your DevOps projects.

In the below example I share the tree structure of general Ansible projects and how I use ```.gitmodules``` to pull in community and custom roles for managing projects.

## Tree Listing of Structure

```
$  tree -a -L 3
.
├── ansible.cfg
├── CHANGELOG.md
├── .gitlab-ci.yml
├── .gitmodules
├── git-submodules.sh
├── inventory
│   ├── group_vars
│   │   └── group1
│   │       ├── vars.yml
│   │       └── vault
│   ├── host_vars
│   │   └── host1.example.com
│   │       ├── vars.yml
│   │       └── vault
│   │   └── host2.example.com
│   │       ├── vars.yml
│   │       └── vault
│   └── inventory
├── LICENCE.md
├── playbooks
│   └── ping.yml
├── README.md
├── roles
│   ├── geerlinguy.java
│   │   ├── defaults
│   │   ├── .gitignore
│   │   ├── LICENSE
│   │   ├── meta
│   │   ├── molecule
│   │   ├── README.md
│   │   ├── tasks
│   │   ├── templates
│   │   ├── .travis.yml
│   │   └── vars
│   └── willhallonline.acme_sh
│       ├── defaults
│       ├── .gitignore
│       ├── LICENSE
│       ├── meta
│       ├── molecule
│       ├── README.md
│       ├── tasks
│       ├── .travis.yml
│       └── vars
└── vars
    └── vars.yml
```

## Ansible ```ansible.cfg``` file

I like to be able to change my ```ansible.cfg``` for each project as required (my preference is to use Mitogen but it doesn't work via Jump hosts very well). Largely I keep the basic setup of ```ansible.cfg``` with a few small adjustments to accomodate the directory structure. I usually place these at the end of the ```[defaults]``` section.

### Ansible ```ansible.cfg``` Example

```
...
inventory = ./inventory/inventory
roles_path =./roles
host_key_checking = False
retry_files_enabled = False
remote_user = ansible
gathering = smart
strategy_plugins = /usr/lib/python2.7/site-packages/ansible_mitogen/plugins/strategy 
strategy = mitogen_linear
```

As you can see there a a few changes. I adjust the location of roles and inventory, set ```retry_files_enabled``` and ```host_key_checking``` as *False*, set ```remote_user``` as ```ansible``` and finally add in Mitogen (if you are not using Mitogen you can comment this out). 

## Markdown files

The first level is really the basic project setup for any code project. I normally like to be explicit with regards to the file format (I like having file extensions) so I use the *.md extension where possible. This gives us the:

* CHANGELOG.md
* LICENCE.md
* README.md

## Continuous Integration/Testing

As I mainly use GitLab CI for testing then I include a ```.gitlab-ci.yml``` file however, if you are working with other CI tools then use them (```.travis.yml``` or ```.circle-ci.yml```). For general CI work I normally look at using ```yamllint``` on every ```*.yml``` file which means that the 

## Ansible Directory Structure

The directory structures I normally use are based around 5 years of experience using Ansible. We want to be able to separate generally our *inventory*, *roles*, and *playbooks*. I normally also place a *vars* directory although looking through some live projects I can see that I barely ever use it unless the project is really a single use project.

## Ansible ```inventory``` Directory

Ansible does allow an amount of flexibility with the use of files, however, I normally like to keep all *inventory* files inside the same directory. As the ```inventory/inventory``` file does not have linting and therefore I do not put an extension on it.

### Ansible ```host_vars``` and ```group_vars``` Directory

The host vars and group vars are the main location for all variables with regards to projects, these are normally separated inside the ```host_var``` directory with the ```{{ inventory_hostname }}```, however, this can change when loading local hosts of hosts via a VPN.

Inside the directories I keep a ```vars.yml``` and ```vault``` files. These serve as all of the variables for the playbooks that are being run. Obviously I use [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) for encryption of any secure credentials and normally decrypt on runtime with a password ```--ask-vault-pass```.

Keeping ```vars.yml``` separate enabled you to be able to lint the directories whilst also enabling easy changing of details.

## Ansible ```roles``` Directory

Inside the ```roles``` directory I normally keep a mix of both community and custom roles. Ideally they are all version controlled elsewhere and pulled in using ```.gitmodules```. And updated with ```$  git submodule update --remote```.

In the example tree above, I use both have used both the ```willhallonline.acme_sh``` and the ```geerlinguy.java``` role. As they have been cloned from github, I use a ```{github-username}.{role-name}``` structure for the roles. This not only means that the roles are relatively well understood, but that you can relatively easily include them inside playbooks.

### Example ```.gitmodules``` for Ansible Roles

```git
[submodule "roles/geerlingguy.java"]
	path = roles/geerlingguy.java
	url = https://github.com/geerlingguy/ansible-role-java.git
[submodule "roles/willhallonline.acme_sh"]
	path = roles/willhallonline.acme_sh
	url = https://github.com/willhallonline/ansible-role-acme_sh.git
```

This can be deployed easily with the included ```git-submodules.sh``` script that I include find out more about [Scripting the adding of Git Submodules](https://www.willhallonline.co.uk/blog/2019-03-05-scripting-adding-gitmodules/).

## Ansible ```playbooks``` Directory

I try to keep the ```playbooks``` directory flat, putting descriptive names for the playbooks. A playbook I try to keep everywhere is a simple ping playbook which will confirm connection.

### Example ```ping.yml``` Playbook

```yml
---
- hosts: all
  tasks:
    - ping:

```

## End

Hopefully this helps with future structuring of Ansible projects and do let me know if you think I could do some changes.

* Will Hall (will@willhallonline.co.uk)
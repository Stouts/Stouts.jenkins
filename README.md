Stouts.jenkins
==============


[![Build Status](http://img.shields.io/travis/Stouts/Stouts.jenkins.svg?style=flat-square)](https://travis-ci.org/Stouts/Stouts.jenkins)
[![Galaxy](http://img.shields.io/badge/galaxy-Stouts.jenkins-blue.svg?style=flat-square)](https://galaxy.ansible.com/list#/roles/858)

Ansible role which manage [Jenkins CI](http://jenkins-ci.org/)

* Install and configure Jenkins
* Proxy jenkins with nginx/apache (supports http auth)
* Setup SSH credentials for Jenkins (key, knownhosts)
* Install Jenkins plugins
* Manage Jenkins jobs

> The role needs a root access to run.
> Add `sudo: yes` in your playbook.

> The role does not install a proxy server (nginx, apache)
> I recommed to use other roles for install proxies (example
> [Stouts.nginx](https://github.com/Stouts/Stouts.nginx))


#### Variables

Here is the list of all variables and their default values:

```yaml
jenkins_enabled: yes                        # The role is enabled

jenkins_name: jenkins
jenkins_user: jenkins
jenkins_group: jenkins
jenkins_configuration: /etc/default/jenkins
jenkins_home: /var/lib/jenkins              # Jenkins home location
jenkins_root: /usr/share/jenkins            # Location of jenkins arch indep files

jenkins_http_host: 127.0.0.1                # Set HTTP host
jenkins_http_port: 8000                     # Set HTTP port
jenkins_url: http://{{jenkins_http_host}}:{{jenkins_http_port}}
jenkins_cli_extra_opts: ""                  # Extra options for jenkins-cli.jar

jenkins_ssh_key_file: ""                    # Set private ssh key for Jenkins user (path to local file)
# Jenkins ssh keys object
# - file_name: id_rsa  # optional defaults to id_rsa; please set if you have multiple
#   private_key: |
#     -----BEGIN RSA PRIVATE KEY-----
#     Proc-Type: 4,ENCRYPTED
#     DEK-Info: AES-128-CBC,.....
jenkins_ssh_keys: []                        # Set multiple private keys from vault or vars
jenkins_ssh_fingerprints:                   # Set known hosts for ssh
  - "bitbucket.org,131.103.20.167 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw=="
  - "github.com,204.232.175.90 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="

jenkins_proxy: ""                           # Enable jenkins proxy. Values are: nginx, apache
jenkins_proxy_hostname: "{{inventory_hostname}}" # Set proxy servername
jenkins_proxy_port: 80                      # Set proxy port
jenkins_proxy_ssl: false                    # Enable SSL
jenkins_proxy_ssl_certificate: /etc/nginx/ssl/certificate.crt # Path to certificate
jenkins_proxy_ssl_key: /etc/nginx/ssl/certificate.key         # Path to key
jenkins_proxy_auth: no                      # Enable http auth
jenkins_proxy_auth_users: []                # Add http auth users
                                            # jenkins_proxy_auth_users:
                                            #   - { name: team, password: secret }

#latest
#jenkins_apt_key: "http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key"
#jenkins_apt_repository: "deb http://pkg.jenkins-ci.org/debian binary/"
#latest stable
jenkins_apt_key: http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key
jenkins_apt_key_id: D50582E6
jenkins_apt_repository: deb http://pkg.jenkins-ci.org/debian-stable binary/

jenkins_apt_packages: []                    # Ensure the packages installed
jenkins_plugins: []                         # Ensure the plugins is installed
jenkins_jobs: []                            # Simple manage Jenkins jobs
                                            # Ex. jenkins_jobs:
                                            #       - name: job
                                            #         action: enable  # (enable|disable|delete)
                                            #       - name: job2
                                            #         template: mytemplate.xml  # using custom template
                                            #       - name: mixer
                                            #         repo: https://github.com/klen/mixer
                                            #         branch: origin/develop
                                            #         command: make test

jenkins_java: /usr/bin/java
jenkins_java_args:
  - "-Djava.awt.headless=true"
jenkins_pidfile: /var/run/jenkins.pid
jenkins_prefix: "/"
jenkins_run_standalone: yes
jenkins_war: "{{ jenkins_root }}/jenkins.war"

# System config
# =============
jenkins_system_config:
  admin_email: nobody@example.com

# Logging
# =======
jenkins_log: "{{ jenkins_logdir }}/{{ jenkins_name }}.log"
jenkins_logdir: /var/log/jenkins            # Jenkins logs location
jenkins_logrotate: yes                      # Rotate Jenkins logs.
jenkins_logrotate_options:
  - compress
  - copytruncate
  - daily
  - dateext
  - rotate 7
  - size 10M

jenkins_check_jobs:                         # Checking jobs during a provision
                                            # Ensure the last build is success, before update
                                            # Eg. jenkins_check_jobs:
                                            #     - url: http://jenkins.project.com
                                            #       job: project-develop

docker_files_generated_directory: "./"
docker_files_enable: no
docker_volume_directory                  : "{{ jenkins_home }}"
docker_working_directory                 : "/home/vagrant"
docker_image_name                        : "nabla/ansible-jenkins-master"
```

#### Usage

Add `Stouts.jenkins` to your roles and setup the variables in your playbook file.
Example:

```yaml

- hosts: all

  roles:
    - Stouts.jenkins

  vars:
      jenkins_proxy: nginx
      jenkins_proxy_hostname: jenkins.myhost.com
      jenkins_ssh_key_file: "{{inventory_dir}}/jenkins/ssh_key"
      jenkins_jobs:
      - name: mixer
        repo: https://github.com/klen/mixer.git
        command: make test
```

#### Check builds during provision

You could use the role for checking builds during provision.
By example, update servers only if last build was successful:

```yaml

- hosts: all

  roles:
    - Stouts.jenkins
    ...                             # Other server roles

  vars:
      jenkins_enabled: no           # We dont need to install Jenkins on this host
      jenkins_check_jobs:
      - url: jenkins.myproject.com  # Url when jenkins is installed
        job: myproject-master       # Job name
        user: myproject             # (optional) HTTP Basic Auth
        password: mypassword
```

In this example, provision will continue only if last build was success.

#### License

Licensed under the MIT License. See the LICENSE file for details.

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Stouts/Stouts.jenkins/issues)!

If you wish to express your appreciation for the role, you are welcome to send
a postcard to:

    Kirill Klenov
    pos. Severny 8-3
    MO, Istra, 143500
    Russia

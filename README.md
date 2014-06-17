Stouts.jenkins
==============

[![Build Status](https://travis-ci.org/Stouts/Stouts.jenkins.png)](https://travis-ci.org/Stouts/Stouts.jenkins)

Ansible role which manage [Jenkins CI](http://jenkins-ci.org/)

* Install and configure Jenkins
* Proxy jenkins with nginx/apache (supports http auth)
* Setup SSH credentials for Jenkins (key, known_hosts)
* Install Jenkins plugins
* Manage Jenkins jobs

TODO:
* Create jobs


#### Variables

Here is the list of all variables and their default values:

```yaml
jenkins_enabled: yes                        # The role is enabled
jenkins_name: jenkins
jenkins_user: jenkins
jenkins_group: jenkins
jenkins_http_port: 8000                     # Set jenkins port
jenkins_ssh_key_file: ""                    # Set private ssh key for Jenkins user (path to key)
jenkins_ssh_fingerprints:                   # Set known hosts for ssh
  - "bitbucket.org,131.103.20.167 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw=="
  - "github.com,204.232.175.90 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="

jenkins_proxy: ""                           # Enable jenkins proxy. Values are: nginx, apache
jenkins_proxy_hostname: ""                  # Set proxy servername
jenkins_proxy_port: 80                      # Set proxy port
jenkins_proxy_auth: yes                     # Enable http auth
jenkins_proxy_auth_users: []                # Add http auth users
                                            # jenkins_proxy_auth_users:
                                            #   - { name: team, password: secret }

jenkins_apt_packages: []                    # Ensure the packages installed
jenkins_plugins: []                         # Ensure the plugins is installed
jenkins_jobs: []                            # Simple manage Jenkins jobs
                                            # Ex. jenkins_jobs:
                                            #       - name: job
                                            #         action: enable  # (enable|disable|delete)
                                            #       - name: test
                                            #         action: disable

jenkins_configuration: /etc/default/jenkins
jenkins_home: /var/lib/jenkins
jenkins_logdir: /var/log/jenkins
jenkins_java: /usr/bin/java
jenkins_log: "{{jenkins}logdir}}/{{jenkins_name}}.log"
jenkins_pidfile: /var/run/jenkins.pid
jenkins_prefix: "/"
jenkins_run_standalone: yes
jenkins_war: /usr/share/jenkins/jenkins.war
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
      jenkins_ssh_key_file: "{{resources_to}}/resources/jenkins/ssh_key"    # (you can manage remote files with Stouts.resources role)
      jenkins_jobs:
        - name: test
          action: delete
```

#### License

Licensed under the MIT License. See the LICENSE file for details.

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Stouts/Stouts.jenkins/issues)!

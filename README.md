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
jenkins_ssh_known_hosts: []                 # Set known hosts for ssh

jenkins_proxy: ""                           # Enable jenkins proxy. Values are: nginx, apacha
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
      jenkins_ssh_known_hosts:
        - bitbucket.org
        - github.com
      jenkins_jobs:
        - name: test
          action: delete
```

#### License

Licensed under the MIT License. See the LICENSE file for details.

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Stouts/Stouts.jenkins/issues)!

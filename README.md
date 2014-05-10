Stouts.jenkins
==============

[![Build Status](https://travis-ci.org/Stouts/Stouts.jenkins.png)](https://travis-ci.org/Stouts/Stouts.jenkins)

Ansible role which manage Jenkins CI

* Install and configure Jenkins
* Proxy jenkins with nginx
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
jenkins_plugins: []                         # Ensure the plugins is installed
jenkins_jobs: []                            # Simple manage Jenkins jobs
                                            # Ex. jenkins_jobs:
                                            #       - name: job
                                            #         action: enable  # (enable|disable|delete)
                                            #       - name: test
                                            #         action: disable
jenkins_nginx_proxy: no                     # Enable nginx proxy
jenkins_nginx_hostname: ""                  # Set jenkins host
jenkins_configuration: /etc/default/jenkins
jenkins_home: /var/lib/jenkins
jenkins_java: /usr/bin/java
jenkins_logdir: /var/log/jenkins
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
    - jenkins_nginx_proxy: yes
    - jenkins_nginx_hostname: jenkins.myhost.com
```

#### License

Licensed under the MIT License. See the LICENSE file for details.

#### Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/Stouts/Stouts.jenkins/issues)!

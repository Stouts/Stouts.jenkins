# Ansible managed: /workspace/users/albandri10/env/ansible/roles/jenkins-master/templates/Dockerfile.j2 modified on 2014-10-16 01:13:11 by albandri on albandri-laptop-misys.misys.global.ad
#FROM        debian:jessie
#FROM        stackbrew/ubuntu:14.04
FROM        jasongiedymin/ansible-base-ubuntu

# Volume can be accessed outside of container
VOLUME      [/var/lib/jenkins]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu"

ENV			DEBIAN_FRONTEND noninteractive
ENV         JENKINS_HOME /var/lib/jenkins
ENV         WORKDIR /home/vagrant

# Working dir
WORKDIR /home/vagrant

# COPY
#COPY

RUN         pwd
RUN         ls -lrta

# ADD
ADD defaults $WORKDIR/ansible-jenkins-master/defaults
ADD meta $WORKDIR/ansible-jenkins-master/meta
ADD files $WORKDIR/ansible-jenkins-master/files
ADD handlers $WORKDIR/ansible-jenkins-master/handlers
ADD tasks $WORKDIR/ansible-jenkins-master/tasks
ADD templates $WORKDIR/ansible-jenkins-master/templates
ADD vars $WORKDIR/ansible-jenkins-master/vars

# Here we continue to use add because
# there are a limited number of RUNs
# allowed.
ADD hosts /etc/ansible/hosts
ADD jenkins-master.yml $WORKDIR/ansible-jenkins-master/jenkins-master.yml

# Execute
RUN         pwd
RUN         ls -lrta
RUN         ansible-playbook $WORKDIR/ansible-jenkins-master/jenkins-master.yml -c local -vvvv

#RUN apt-get update && apt-get clean
#RUN apt-get install -q -y openjdk-7-jre-headless 
#RUN apt-get install -y tomcat6
#RUN apt-get clean

EXPOSE 21:9999
ENTRYPOINT  ["/etc/init.d/jenkins", "start"]
CMD ["-g", "deamon off;"]

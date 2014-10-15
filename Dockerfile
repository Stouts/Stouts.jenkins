# Ansible managed: /workspace/users/albandri10/env/ansible/roles/jenkins-master/templates/Dockerfile.j2 modified on 2014-09-16 01:17:51 by albandri on albandri-laptop-misys
FROM        stackbrew/ubuntu:14.04
#FROM        debian:jessie

VOLUME      ["/var/log/jenkins"]

MAINTAINER  Alban Andrieu "https://github.com/AlbanAndrieu/nabla"

ENV			DEBIAN_FRONTEND noninteractive
#ENV         JENKINS_HOME /jenkins

RUN apt-get update && apt-get clean
RUN apt-get install -q -y openjdk-7-jre-headless 
RUN apt-get install -y tomcat6
RUN apt-get clean

EXPOSE 8080
ENTRYPOINT  ["/etc/init.d/jenkins", "start"]
#ENTRYPOINT ["java", "-jar", "/opt/jenkins.war"]
CMD ["-g", "deamon off;"

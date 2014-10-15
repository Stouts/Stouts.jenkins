#!/bin/bash
# Ansible managed: /workspace/users/albandri10/env/ansible/roles/zap/templates/build.sh.j2 modified on 2014-09-25 11:57:15 by albandri on albandri-laptop-misys

DOCKERNAME="nabla/ansible-zap"

time docker build -t $DOCKERNAME .

echo
echo "This image is a trusted docker.io Image."
echo
echo "To pull it"
echo "    docker pull $DOCKERNAME"
echo
echo "To use this docker:"
echo "    docker run -d -P $DOCKERNAME"
echo
echo "To run in interactive mode for debug:"
echo "    docker run -t -i $DOCKERNAME bash"
echo

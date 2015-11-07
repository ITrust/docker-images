from ansible/ubuntu14.04-ansible

ADD ansible /srv/ansible
WORKDIR /srv/ansible
RUN ansible-playbook cython-ubuntu.yml -c local
VOLUME /src
from ansible/ubuntu14.04-ansible

ADD ansible /srv/ansible
WORKDIR /srv/ansible
RUN ansible-playbook docker-curator.yml -c local
ENV PATH=/usr/local/bin:$PATH
ENV SCHEDULE "* * * * * *"
ENV COMMAND "echo test go-cron"
EXPOSE 8080
CMD go-cron-linux -s "$SCHEDULE" -p 8080 -- /bin/bash -c "$COMMAND"


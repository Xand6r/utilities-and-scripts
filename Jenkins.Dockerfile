FROM jenkins/jenkins:2.263.1-lts-slim
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get remove cmdtest && apt-get remove yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt install -y nodejs npm yarn
RUN apt install ansible -y
RUN apt install -y python3-pip
COPY ansible/.inventory /etc/ansible/hosts
COPY ansible/.config /etc/ansible/ansible.cfg
COPY ansible/playbooks /etc/ansible/playbooks
RUN mkdir -p /root/.ssh
COPY ssh/id_rsa /root/.ssh/id_rsa
COPY ssh/id_rsa.pub /root/.ssh/id_rsa.pub
RUN chmod 700 /root/.ssh/id_rsa
RUN ls /root/.ssh

FROM cloudtrust-baseimage:f27

ARG service_git_tag

ARG unbound_version=1.7.3-3.fc27

RUN dnf update -y && \
    dnf install -y unbound-$unbound_version && \
    dnf clean all

WORKDIR /cloudtrust
RUN git clone git@github.com:cloudtrust/unbound-service.git

WORKDIR /cloudtrust/unbound-service
RUN git checkout ${service_git_tag} && \
    install -v -m664 deploy/etc/systemd/system/unbound.service /etc/systemd/system/unbound.service

RUN systemctl enable unbound

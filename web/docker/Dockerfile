FROM moodlehq/moodle-php-apache:7.4-buster

# Setup the required extensions.
ARG DEBIAN_FRONTEND=noninteractive
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN apt-get update && apt-get install -y --no-install-recommends wget gnupg apt-utils vim git && \
    wget -O - https://download.gluster.org/pub/gluster/glusterfs/7/rsa.pub | apt-key add - && \
    DEBID=$(grep 'VERSION_ID=' /etc/os-release | cut -d '=' -f 2 | tr -d '"') && \
    DEBVER=$(grep 'VERSION=' /etc/os-release | grep -Eo '[a-z]+') && \
    DEBARCH=$(dpkg --print-architecture) && \
    echo deb https://download.gluster.org/pub/gluster/glusterfs/LATEST/Debian/${DEBID}/${DEBARCH}/apt ${DEBVER} main > /etc/apt/sources.list.d/gluster.list && \
    apt-get update && apt-get install -y --no-install-recommends glusterfs-client && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

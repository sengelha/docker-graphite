FROM phusion/baseimage:0.9.18
MAINTAINER Steven Engelhardt <sengelha@gmail.com>

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN apt-get -y install python-dev
RUN pip install twisted==11.1.0

# install whisper
RUN mkdir /tmp/whisper
RUN wget https://launchpad.net/graphite/0.9/0.9.10/+download/whisper-0.9.10.tar.gz -O /tmp/whisper/whisper-0.9.10.tar.gz
RUN tar zxvf /tmp/whisper/whisper-0.9.10.tar.gz -C /tmp/whisper
WORKDIR /tmp/whisper/whisper-0.9.10
RUN python ./setup.py install

# install carbon
RUN mkdir /tmp/carbon
RUN wget https://launchpad.net/graphite/0.9/0.9.10/+download/carbon-0.9.10.tar.gz -O /tmp/carbon/carbon-0.9.10.tar.gz
RUN tar zxvf /tmp/carbon/carbon-0.9.10.tar.gz -C /tmp/carbon 
WORKDIR /tmp/carbon/carbon-0.9.10
RUN python ./setup.py install

# configure carbon
# TODO: Change this to ADD conf/...
RUN cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
RUN cp /opt/graphite/conf/storage-schemas.conf.example /opt/graphite/conf/storage-schemas.conf

# logging support
ADD conf/logrotate /etc/logrotate.d/graphite
RUN chmod 644 /etc/logrotate.d/graphite

# setup daemons
ADD daemons/carbon.sh /etc/service/carbon/run

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*
RUN rm -rf /var/tmp/*

EXPOSE 2003
VOLUME ["/opt/graphite/storage/whisper", "/var/log"]
ENV HOME /root
CMD ["/sbin/my_init"]

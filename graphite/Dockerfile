FROM phusion/baseimage:0.9.18
MAINTAINER Steven Engelhardt <sengelha@gmail.com>

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install wget
RUN apt-get -y install python
RUN apt-get -y install python-pip
RUN apt-get -y install python-flup
RUN apt-get -y install nginx
RUN apt-get -y install expect
RUN apt-get -y install python-cairo
RUN pip install django==1.3
RUN pip install django-tagging==0.3.1

# install whisper
RUN mkdir /tmp/whisper
RUN wget https://launchpad.net/graphite/0.9/0.9.10/+download/whisper-0.9.10.tar.gz -O /tmp/whisper/whisper-0.9.10.tar.gz
RUN tar zxvf /tmp/whisper/whisper-0.9.10.tar.gz -C /tmp/whisper
WORKDIR /tmp/whisper/whisper-0.9.10
RUN python ./setup.py install

# install graphite
RUN mkdir /tmp/graphite-web
RUN wget https://launchpad.net/graphite/0.9/0.9.10/+download/graphite-web-0.9.10.tar.gz -O /tmp/graphite-web/graphite-web-0.9.10.tar.gz
RUN tar zxvf /tmp/graphite-web/graphite-web-0.9.10.tar.gz -C /tmp/graphite-web
WORKDIR /tmp/graphite-web/graphite-web-0.9.10
RUN python ./setup.py install

# configure graphite
RUN ls -al /opt/graphite/conf/
ADD conf/graphite/local_settings.py /opt/graphite/webapp/graphite/local_settings.py

# initial setup of sqlitedb
# TODO: Either make the sqlitedb an exported volume or use a real DB
ADD scripts/django_admin_init.exp /usr/local/bin/django_admin_init.exp
RUN /usr/local/bin/django_admin_init.exp

# configure nginx
RUN rm /etc/nginx/sites-enabled/default
ADD conf/nginx/nginx.conf /etc/nginx/nginx.conf
ADD conf/nginx/graphite.conf /etc/nginx/sites-available/graphite.conf
RUN ln -s /etc/nginx/sites-available/graphite.conf /etc/nginx/sites-enabled/graphite.conf

# configure logging
RUN mkdir -p /var/log/graphite /var/log/nginx
ADD conf/logrotate /etc/logrotate.d/graphite
RUN chmod 644 /etc/logrotate.d/graphite

# setup daemons
ADD daemons/graphite.sh /etc/service/graphite/run
ADD daemons/nginx.sh /etc/service/nginx/run

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /tmp/*
RUN rm -rf /var/tmp/*

EXPOSE 80
VOLUME ["/opt/graphite/storage/whisper", "/var/log"]
ENV HOME /root
CMD ["/sbin/my_init"]

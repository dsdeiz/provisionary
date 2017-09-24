FROM ubuntu:zesty

RUN apt-get update -y && apt-get upgrade -y

COPY provisioner.sh /provisioner.sh
RUN /provisioner.sh

RUN apt-get install supervisor -y

COPY supervisor-provisioner.conf /etc/supervisor/conf.d/supervisor-provisioner.conf

# Create unexisting directories?
RUN mkdir /var/run/php && chown www-data /var/run/php
RUN mkdir /var/run/mysqld && chown mysql /var/run/mysqld

COPY setup-drupal.sh /setup-drupal.sh
RUN /setup-drupal.sh

RUN sed -i '/auth_/d' /etc/nginx/sites-available/dynamic.conf

EXPOSE 80

CMD ["supervisord", "-n"]

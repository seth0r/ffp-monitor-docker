FROM ubuntu:18.04
MAINTAINER me+docker@seth0r.net

RUN apt-get update 
RUN apt-get dist-upgrade -y
RUN apt-get -y install gnupg wget cron mysql-server mongodb apache2 python3 vim

RUN wget -qO- https://repos.influxdata.com/influxdb.key | apt-key add -
RUN echo "deb https://repos.influxdata.com/ubuntu bionic stable" | tee /etc/apt/sources.list.d/influxdb.list
RUN apt-get update 
RUN apt-get -y install influxdb

RUN wget -qO- https://packages.grafana.com/gpg.key | apt-key add -
RUN echo "deb https://packages.grafana.com/oss/deb stable main" | tee /etc/apt/sources.list.d/grafana.list
RUN apt-get update 
RUN apt-get -y install grafana

#RUN apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Copy hello-cron file to the cron.d directory
#COPY backup-cron /etc/cron.d/backup-cron

# Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/backup-cron

# Apply cron job
#RUN crontab /etc/cron.d/backup-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log

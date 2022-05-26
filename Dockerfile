FROM python:3.9.0-slim-buster
ENV PYTHONUNBUFFERED 1

# FIX OSError: Could not find library geos_c or load any of its variants ['libgeos_c.so.1', 'libgeos_c.so']
RUN apt-get update -y
RUN apt-get install -y libgeos-dev

RUN apt-get install -y gettext
    #&& apt-get install -y cron

# Install postgres requirements
RUN apt-get install -y \
    libgeos-dev \
    libgdal-dev \
    postgresql-client \
    mc


#RUN echo "1. SERVER_TYPE is $SERVER_TYPE"
#RUN echo "2. SERVER_TYPE next $SERVER_TYPE"

# INSTALL CHROME
# 1. install chrome driver for selenium testing and add chromedriver
COPY ./chrome/chromedriver /usr/bin/chromedriver
RUN chmod 0777 /usr/bin/chromedriver
# 2. install chrome
# http://ftp.debian.org/debian/pool/main/c/cups/libcups2_2.2.10-6+deb10u5_amd64.deb
COPY ./chrome/google-chrome-stable_current_amd64.deb /google-chrome-stable_current_amd64.deb

RUN apt-get install -y \
    libcups2 \
    /google-chrome-stable_current_amd64.deb

#RUN dpkg -i /google-chrome-stable_current_amd64.deb
# END INSTALL CHROME

# INSTALL FIREFOX - NOW USING, ONLY CHROME FOR ALL SERVERS
# 1. install firefox driver
# --- LOC AND DEV SERVER START HERE
#ARG GECKODRIVER_VERSION=v0.30.0
#COPY ./docker/django/firefox/amd64/geckodriver.tar.gz /tmp/geckodriver.tar.gz
#RUN chmod 0777 /tmp/geckodriver.tar.gz
#RUN tar xzf /tmp/geckodriver.tar.gz -C /opt \
#	&& rm /tmp/geckodriver.tar.gz \
#	&& mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
#	&& ln -s /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver

# 2. install firefox
#ARG FIREFOX_VERSION=96.0
#COPY ./docker/django/firefox/amd64/firefox.tar.bz2 /tmp/firefox.tar.bz2
#RUN chmod 0777 /tmp/firefox.tar.bz2
#RUN apt-get update -qqy \
#	&& apt-get -qqy install libgtk-3-0 libx11-xcb1 libdbus-glib-1-2 libxt6 \
#	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*
#RUN tar xjf /tmp/firefox.tar.bz2 -C /opt \
#	&& rm /tmp/firefox.tar.bz2 \
#	&& mv /opt/firefox /opt/firefox-$FIREFOX_VERSION \
#	&& ln -s /opt/firefox-$FIREFOX_VERSION/firefox /usr/bin/firefox

# END FIREFOX

# /bin/sh: 1: [: missing ]

#RUN rm -rf node_modules
#RUN apt-get install -y nodejs
#RUN apt-get install -y npm
#RUN npm install
#RUN ./node_modules/.bin/gulp prod

WORKDIR /app


#ENTRYPOINT ["/django/idle.sh"]

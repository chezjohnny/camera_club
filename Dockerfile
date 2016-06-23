FROM python:2.7-slim

MAINTAINER Johnny Mariéthoz <chezjohnny@gmail.com>

#needed by some python modules
#RUN apt-get update -y && apt-get install -y gcc curl

# Node.js, bower, less, clean-css, uglify-js, requirejs
RUN apt-get update
RUN apt-get -qy upgrade --fix-missing --no-install-recommends
RUN apt-get -qy install --fix-missing --no-install-recommends curl
RUN curl -sL https://deb.nodesource.com/setup_iojs_2.x | bash -

# Install dependencies
RUN apt-get -qy install --fix-missing --no-install-recommends gcc git iojs curl


# website will be in a user directory
ENV HOME /home/camera
RUN useradd --home-dir $HOME --create-home --shell /bin/bash --uid 1000 camera

# for pip --user
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${HOME}/.local/bin

# cd dir
WORKDIR $HOME

# create logs dir and make it persitant
RUN mkdir -p /data && chown camera:camera -R /data
VOLUME ["/data"]

# create working directories
RUN mkdir $HOME/devel $HOME/www

# on the source code dir
WORKDIR ${HOME}/devel

# copy local files on the images
ADD camera_club camera_club
COPY wsgi.py  $HOME/www/
COPY ./setup.py ./MANIFEST.in ./wsgi.py ./runserver.py ./

# adjust dir permissions
RUN chown camera:camera -R /home/camera /data

RUN npm update && npm install --silent -g node-sass clean-css uglify-js requirejs

ENV SASS_BIN node-sass

#switch to user
USER camera

# install js
WORKDIR ${HOME}/devel/camera_club/static
RUN npm install
WORKDIR ${HOME}/devel

# install web server
RUN pip install --user gunicorn eventlet & pip install --user .

# go to the wsgi file
WORKDIR $HOME/www

#
EXPOSE 8000

# default command: run the server
CMD gunicorn --log-file=/data/gunicorn.log --bind 0.0.0.0:8000   -w 3 --worker-connections=2000 --backlog=1000  -k eventlet wsgi
#CMD python runserver.py

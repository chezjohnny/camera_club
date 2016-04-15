FROM python:2.7-slim

MAINTAINER Johnny Mariéthoz <chezjohnny@gmail.com>

#needed by some python modules
RUN apt-get update -y && apt-get install -y gcc curl

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
ADD camera camera
COPY wsgi.py  $HOME/www/
COPY ./setup.py ./MANIFEST.in ./wsgi.py ./runserver.py ./

# adjust dir permissions
RUN chown camera:camera -R /home/camera /data

#switch to user
USER camera

# install web server
RUN pip install --user gunicorn eventlet & pip install --user .

# go to the wsgi file
WORKDIR $HOME/www

#
EXPOSE 8000

# default command: run the server
CMD gunicorn --log-file=/data/gunicorn.log --bind 0.0.0.0:8000   -w 3 --worker-connections=2000 --backlog=1000  -k eventlet wsgi
#CMD python runserver.py

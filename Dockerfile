FROM ubuntu
RUN apt-get update
RUN apt-get -y insatll apache2
COPY build.var/www/html/
ENTRYPOINT apachectl -D FOREGROUND
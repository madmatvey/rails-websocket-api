FROM nginx
# install nginx
RUN apt-get update -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update -y
RUN apt-get install -y nginx

# deamon mode off
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# expose ports
EXPOSE 80 443

# add nginx conf to the conf.d
ADD docker/production/nginx.conf /etc/nginx/conf.d/footvote.conf

# add nginx conf
ADD docker/production/nginx.conf /etc/nginx/sites-available/footvote

# create symlinks
RUN ln -s /etc/nginx/sites-available/footvote /etc/nginx/sites-enabled/

WORKDIR /etc/nginx

CMD ["nginx"]

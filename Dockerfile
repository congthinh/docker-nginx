## Mobivi NginX Docker file
## May 2016

FROM nginx:1.9.15
MAINTAINER Thinh Huynh "thinhhc@gmail.com"

## Add Ubuntu Xenial to sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main universe" >> /etc/apt/sources.list

# Let the container know that there is no tty 
ENV DEBIAN_FRONTEND noninteractive

#Update repo
RUN apt-get update

# Download and Install Nginx
RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# add index file 
ADD src/index.html /var/www/public/index.html
RUN chown -Rf www-data.www-data /var/www/public

# Expose ports
EXPOSE 80

CMD service nginx start

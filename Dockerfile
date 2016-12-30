FROM nginx:1.11.8

# Copies all files into the default directory nginx serves from
# See /etc/nginx/conf.d/default.conf
COPY site /usr/share/nginx/html

#!/bin/bash
source /appenv/bin/activate
/appenv/bin/uwsgi --ini /app/app-server.ini &
/usr/sbin/nginx  -g "daemon off;"
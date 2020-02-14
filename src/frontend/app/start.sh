#!/bin/bash
source /appenv/bin/activate
/appenv/bin/uwsgi --ini /app/frontend.ini &
/usr/sbin/nginx  -g "daemon off;"
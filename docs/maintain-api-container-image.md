### Maintaining API Image

To perform ongoing maintenance of the application source files we can run a container using build-flask image. We can clone the GitHub repository to laptop and form a binding so these can be ran within the container. As the source files are only bound to the container we can edit and manage the source code commits with desktop editior like Visual Studio Code.

``` shell
docker container run --interactive --tty --rm --publish 8090:80 --mount type=bind,source=/Users/dcauldwell/Library/Mobile\ Documents/com\~apple\~CloudDocs/Development/Home/planespotters/src/api/app,target=/app --name api vmwareacecs/build-flask /bin/bash
```

We can look to create a Python virtual environment and install the Python packages which the application requires.

``` shell 
virtualenv /appenv
cd /appenv
source /appenv/bin/activate
pip install -r /app/requirements.txt
```

The frontend microservice needs to talk to the database and redis environment variables are used to configure where and how to connect.

```
DATABASE_URL = 'mysql.yflab.de'
DATABASE_USER = 'planespotter'
DATABASE_PWD = 'VMware1!'
DATABASE = 'planespotter'
REDIS_HOST = 'redis.yflab.de'
REDIS_PORT = '6379'
LISTEN_PORT = '80'
```

The app-server.ini includes application log location the default is to write to /var/log/uwsgi/%n.log we must create this folder.

``` shell
mkdir -p /var/log/uwsgi
```

We need to change Nginx default configuration to point to the Unix socket file frontend.sock from uWSGI process.

``` shell
cat << EOF > /etc/nginx/sites-enabled/default
server {
    listen 80;
    server_name default;
    location / {
        include uwsgi_params;
        uwsgi_pass unix:/appenv/app-server.sock;
    }
}
EOF
```

Both Nginx and uWSGI processees need to be running, we can use a script to give us a singular entrypoint and have it activate the virtual environment and spawns the Nginx and uWSGI processes.

``` shell
chmod +x /app/start.sh
/app/start.sh
```

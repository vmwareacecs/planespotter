### Maintaining Frontend Image

To perform ongoing maintenance of the application source files we can run a container using build-flask image. We can clone the GitHub repository to laptop and form a binding so these can be ran within the container. As the source files are only bound to the container we can edit and manage the source code commits with desktop editior like Visual Studio Code. If we expose the Nginx web server port 80 as port 8080 when the processes are running in container we can open a browser to localhost:8080 and view the effect of source code changes.

``` shell
docker container run --interactive --tty --rm --publish 8080:80 --mount type=bind,source=/Users/dcauldwell/Library/Mobile\ Documents/com\~apple\~CloudDocs/Development/Home/planespotters/src/frontend/app,target=/app --name frontend vmwareacecs/build-flask /bin/bash
```

We can look to create a Python virtual environment and install the Python packages which the application requires.

``` shell
virtualenv /appenv
cd /appenv
source /appenv/bin/activate
pip install -r /app/requirements.txt
```

The frontend microservice needs to talk to the API microservice an environment variable is used to configure where to connect.

```
PLANESPOTTER_API_ENDPOINT=planespotter-api.yflab.de
```

The frontend.ini includes application log location the default is to write to /var/log/uwsgi/%n.log we must create this folder.

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
        uwsgi_pass unix:/appenv/frontend.sock;
    }
}
EOF
```

Both Nginx and uWSGI processees need to be running, we can use a script to give us a singular entrypoint and have it activate the virtual environment and spawns the Nginx and uWSGI processes.

``` shell
chmod +x /app/start.sh
/app/start.sh
```

### Maintaining Sync Image

To perform ongoing maintenance of the application source files we can run a container using build-flask image. We can clone the GitHub repository to laptop and form a binding so these can be ran within the container. As the source files are only bound to the container we can edit and manage the source code commits with desktop editior like Visual Studio Code.

``` shell
docker container run --interactive --tty --rm --publish 8100:80 --mount type=bind,source=/Users/dcauldwell/Library/Mobile\ Documents/com\~apple\~CloudDocs/Development/Home/planespotters/src/sync/synchronizer,target=/synchronizer --name sync vmwareacecs/build-flask /bin/bash
```

We can look to create a Python virtual environment and install the Python packages which the application requires.

``` shell 
virtualenv /appenv
cd /appenv
source /appenv/bin/activate
pip install -r /synchronizer/requirements.txt
```

Then start the Python script.

``` shell
/appenv/bin/python -u /synchronizer/adsb-sync.py
```

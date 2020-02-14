## Creating A Python Flask Build Image

We can first clone the public respository locally to a Development folder on our laptop.

``` shell
mkdir ~/Development
cd ~/Development
git clone https://github.com/vmwareacecs/planespotters.git
```

If your not already authenticate with Docker Hub.

``` shell
docker login --username xxx --password yyy
```

The build image extends the base image with some packages and a Python virtual environment. Build and push the build-flask image to the public Docker Hub repository.

``` shell
cd planespotters/img/build-flask
docker build -t vmwareacecs/build-flask .
docker push vmwareacecs/build-flask
```
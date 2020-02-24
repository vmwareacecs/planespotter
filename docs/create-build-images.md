## Creating Python Flask Build Images

The build images used for build activities like development and testing. We can first clone the public respository locally to a Development folder on our laptop.

``` shell
mkdir ~/Development
cd ~/Development
git clone https://github.com/vmwareacecs/planespotters.git
```

If your not already authenticate with Docker Hub.

``` shell
docker login --username xxx --password yyy
```

``` shell
cd planespotters/img/build-flask
docker build -t vmwareacecs/build-flask .
docker push vmwareacecs/build-flask
```


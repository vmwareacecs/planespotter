# Planespotter

This is an example application to demonstrate Kubernetes.

## Monorepo Structure

While we could adopt a repository per microservice to demonstrate more complex release versioning. As the application is simple we will attempt initially to use a single repository with folders and add complexity later if required.

../img contains a folder per container image type used primilarily for dockerfiles
../src contains a folder per microservice which holds application source files and dockerfiles
../tst contains python flask unit and integration test files
../docs contains documentation
../k8s contains kubernetes manifest files

## CI/CD Pipeline Workflow Steps

- Local development using container running in VMware Fusion Project Nautilus ( use Docker Desktop initially until Nautilus layer issue resolved )
- Application source code stored in Distributed Version Control ( public GitHub for easy sharing )
- Jenkins build job per container image type mapped to folder structure to demonstrate enterprise capability
- Docker Compose planesotter mapping source files into running container as volumes to allow source control
- Live view source using Visual Studio Code view changes
- Commit code change to repository
- Jenkins (should we look to Jenkins SaaS or maybe CircleCI ?) build job per microservice mapped to folder structure
- Planespotter written in Python Flask have at least one Flask unit test per microservice and one integration test ( https://flask.palletsprojects.com/en/1.1.x/testing/ )
- Output if tests successful is articfact stored in Container Repository ( public Docker Hub for easy sharing )
- On-demand deployment of project pacific cluster for test with deployed artifact manifest deploys VSAN backed persistent volumes and NSX backed Loadbalancer / Ingress Controller
- Each micrososervice application logs direct to VSAN backed persistent volume shared between members of replica set. How to manage? Does each Pod contain a container running Log Insight agent which reads persistent volume logs and sends them for aggregation? Or does each microservice contain a Pod running Log Insight agent?
- Deomstrate continuous delivery and using Deployment rollout / scale / rollback etc capability for specific micro-service tier version
- Release control gates to test-> staging-> prod

## Container Images Types

- Base ( simulated corporate image )
- Build ( contains dev and test tooling )
- Release ( runtime )

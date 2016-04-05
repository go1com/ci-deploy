# ci-deploy
This image can run the docker inside docker and deploy for GitLab CI

This CI image have docker inside, so its can run [Docker inside Docker](https://blog.docker.com/2013/09/docker-can-now-run-within-docker)

This is very helpful for PHP project need to run script before deploy task, run the docker build and push the image build to service like Docker Hub, Amazon ECS

## PHP
Installed version: 5.6, modules:

- curl
- gd
- mailparse
- mbstring
- mcrypt
- mongo
- mysql
- sqlite

## Python
Installed version: 2.7, latest pip version

## Amazon Client + JQ
Latest aws client + jq command to process json in bash

## Node.JS
Installed version: Latest stable version (5.x)

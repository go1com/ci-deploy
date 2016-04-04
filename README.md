# ci-deploy
This image can run the docker inside docker and deploy for GitLab CI

This CI image have docker inside, so its can run [Docker inside Docker](https://blog.docker.com/2013/09/docker-can-now-run-within-docker)

This is very helpful for PHP project need to run script before deploy task (composer install), run the docker build and push the image build to service like Docker Hub or Amazon ECS

Current installed PHP modules:

- curl
- gd
- mailparse
- mbstring
- mcrypt
- mongo

Python: v2.7

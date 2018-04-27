Apache with Shibboleth-Service Provider installed
===========

Apache instance with Shibboleth-Service Provider  intended to run in a Docker container.

## What's Contained Here?
This builds adds onto the Docker-validated `apache:2` base image. It stages the
Apache 2.X with Shibboleth Service Provider for installation on first run.

GE-specific files are copied into the container at start, and then are used to
overwrite the defaults that the Apache and Shibboleth Service Provider installer creates. These files are stored  
in branches of the repo at
https://github.appl.ge.com/tas/saml-apache-config. Each branch
corresponds to the name of the apache webserver url (`$WEBSERVER_HOST`).

## Building
To build the image, simply clone this repo down and run the following on a
Docker client machine:
`docker build -t voyager-registry-dev.al.ge.com/apachesp:[version] .`

Then push it to the registry with a `docker push` command, using the full URL
for the tag from above.

## Running
To run a container from this image, you need to specify an environment
variable. It is:

  * WEBSERVER_HOST - the Apache webserver to point to (where the SAML Service Provider agent
    runs) 

The `WEBSERVER_HOST` variable *must* match a branch name in the
`saml-apache-config` repo exactly. If it does not, the container will
fail to start.

The following will run the container, based on a build tagged 2.1,
listening on port 443:

```bash
docker run -de WEBSERVER_HOST={webservername}.al.ge.com -p 8443:443 --name=apachesp \
voyager-registry-dev.al.ge.com/apachesp:1.0
```

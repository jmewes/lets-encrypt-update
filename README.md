# Let's Encrypt Update

## Test setup

### Web server

```
cd hello
docker run -d --name my-apache-app -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd
```

**Also see**

- https://www.docker.com/blog/how-to-use-the-apache-httpd-docker-official-image/

### FTP server

```
docker run \
	--detach \
	--env FTP_PASS=123 \
	--env FTP_USER=user \
	--name my-ftp-server \
	--publish 20-21:20-21/tcp \
	--publish 40000-40009:40000-40009/tcp \
	--volume ./hello:/home/user \
	garethflowers/ftp-server
```

**Also see**

- https://github.com/garethflowers/docker-ftp-server

### FTP client

```
docker run -d \
    --name=filezilla \
    -p 5800:5800 \
    -v /var/folders/vs/5v6n2vhj1vz682y8c8rvvdb80000gn/T/tmp.X3tzafIS:/config:rw \
    -v /var/folders/vs/5v6n2vhj1vz682y8c8rvvdb80000gn/T/tmp.yDRAcx8Z:/storage:rw \
    jlesage/filezilla
```

**Also see**

- https://hub.docker.com/r/jlesage/filezilla

## Create new cert

```
cd $(mkdir -d)
certbot certonly --manual --config-dir . --work-dir . --logs-dir .  -d "letsencrypt-update-beispiel.experimental-software.com" --email "jmewes@experimental-software.com"
```

## References

- https://eff-certbot.readthedocs.io/en/latest/using.html#webroot
- https://xyrillian.de/thoughts/posts/how-i-run-certbot.html

# Let's Encrypt Update

## Test setup

### FTP client

```
docker run -d \
    --name=filezilla \
    -p 5800:5800 \
    # -v /var/folders/vs/5v6n2vhj1vz682y8c8rvvdb80000gn/T/tmp.X3tzafIS:/config:rw \
    -v /Users/jmewes:/storage:rw \
    jlesage/filezilla
```

**Also see**

- https://hub.docker.com/r/jlesage/filezilla

## Create new cert

```
cd $(mktemp -d)
certbot certonly --manual --config-dir . --work-dir . --logs-dir .  -d "letsencrypt-beispiel-1.experimental-software.com" --email "jmewes@experimental-software.com"

certbot certonly --manual --config-dir . --work-dir . --logs-dir .  -d "letsencrypt-update-beispiel-1.experimental-software.com" -d "letsencrypt-update-beispiel-2.experimental-software.com" --email "jmewes@experimental-software.com"
```

## References

- https://eff-certbot.readthedocs.io/en/latest/using.html#webroot
- https://xyrillian.de/thoughts/posts/how-i-run-certbot.html

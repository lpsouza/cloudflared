# Cloudflared

Image docker for expose local services to the internet using Cloudflare like a reverse proxy.

DISCLAIMER: Why do you need use this image if you can use [the official one](https://hub.docker.com/r/cloudflare/cloudflared/)? Well, the official image is not thinked to multiple processor architecture. So, this image is designed to work with amd64 and arm64 architectures.

## Running the tunnel

```bash
docker run -d --name cloudflared -v /path/to/tunnel/config:/root/.cloudflared lpsouza/cloudflared
```

The volume `/path/to/tunnel/config` is where the configuration file `config.yaml` and the json certification file are stored.

## Example configuration

### config.yaml

The file `config.yaml` must be created manually. And the `SERVICE_URL` is the url of the service that will be exposed to the internet and the `TUNNEL_ID` is the id of the tunnel. To get the id of the tunnel, run the tunnel creation process.

```yaml
url: SERVICE_URL
tunnel: TUNNEL_ID
credentials-file: /root/.cloudflared/TUNNEL_ID.json
```

### TUNNEL_ID.json

This json file must be created by the Cloudflare tunnel creation process.

```json
{
    "AccountTag": "",
    "TunnelSecret": "",
    "TunnelID": ""
}
```

## Proccess to create a tunnel

### Create a new tunnel

```bash
docker run --rm -ti -v $PWD/cf:/root/.cloudflared test tunnel login
docker run --rm -ti -v $PWD/cf:/root/.cloudflared test tunnel create TUNNEL_NAME
```

This two commands will create a new tunnel and will store the credentials on the folder `$PWD/cf` in the `TUNNEL_ID.json` file. The `TUNNEL_ID` format is a GUID.

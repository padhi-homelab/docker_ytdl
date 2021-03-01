# docker_ytdl <a href='https://github.com/padhi-homelab/docker_ytdl/actions?query=workflow%3A%22Docker+CI+Release%22'><img align='right' src='https://img.shields.io/github/workflow/status/padhi-homelab/docker_ytdl/Docker%20CI%20Release?logo=github&logoWidth=24&style=flat-square'></img></a>

<a href='https://microbadger.com/images/padhihomelab/ytdl'><img src='https://img.shields.io/microbadger/layers/padhihomelab/ytdl/latest?logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/ytdl'><img src='https://img.shields.io/docker/image-size/padhihomelab/ytdl/latest?label=size%20%5Blatest%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>
<a href='https://hub.docker.com/r/padhihomelab/ytdl'><img src='https://img.shields.io/docker/image-size/padhihomelab/ytdl/testing?label=size%20%5Btesting%5D&logo=docker&logoWidth=24&style=for-the-badge'></img></a>

A multiarch [YTDL-Material] Docker image, based on [Alpine Linux].

|        386         |       amd64        |       arm/v6       |       arm/v7       |       arm64        |      ppc64le       |       s390x        |
| :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: |
| :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |


## Usage

```
docker run --detach \
           -p 17442:17442 \
           -it padhihomelab/ytdl
```

Serves YTDL-Material web app on port 17442.

_<More details to be added soon>_


[Alpine Linux]:  https://alpinelinux.org/
[YTDL-Material]: https://github.com/Tzahi12345/YoutubeDL-Material/

# beets

[Beets](http://beets.io) is a music library manager and not, for the most part, a music player. It does include a simple player plugin and an experimental Web-based player, but it generally leaves actual sound-reproduction to specialized tools.

<img src="https://github.com/thetarkus/docker-beets/raw/master/beet.png" alt="beets logo" width="100px"/>

**Fork**  
This is a fork of linuxserver/docker-beets that uses Python 3. This fork also includes the `gmusicapi` pip package for the [Gmusic Plugin](https://beets.readthedocs.io/en/v1.4.7/plugins/gmusic.html).

Be aware that this forks Dockerfile generates a larger image than the linuxserver image.  
Also, be aware that this container will take longer to build (due to pip building `lxml`).


## Usage

```
docker create \
    --name=beets \
    -v <path to config>:/config \
    -v <path to music>:/music \
    -v <path to non-processed music>:/downloads \
    -e PGID=<gid> -e PUID=<uid>  \
    -p 8337:8337 \
    thetarkus/beets
```

## Parameters

* `-p 8337` - the port(s)
* `-v /config` - Configuration files
* `-v /music` - Music library location
* `-v /downloads` - Non-processed music
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it beets /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
$ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Edit the config file in /config

To edit the config from within the container use `beet config -e`

For a command prompt as user abc `docker exec -it -u abc beets /bin/sh`

See [Beets](http://beets.io) for more info.

Contains [beets-copyartifacts](https://github.com/sbarakat/beets-copyartifacts) plugin, [configuration details](https://github.com/sbarakat/beets-copyartifacts#configuration)

## Info

* To monitor the logs of the container in realtime `docker logs -f beets`.

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' beets`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' thetarkus/beets`


## Versions

+ **12.09.18:** Python2 -> python3.
+ **12.08.18:** Add requests pip package, add gmusicapi pip package.
+ **04.03.18:** Upgrade mp3gain to 1.6.1.
+ **02.01.18:** Deprecate cpu_core routine lack of scaling.
+ **27.12.17:** Add beautifulsoup4 pip package.
+ **06.12.17:** Rebase to alpine linux 3.7.
+ **25.05.17:** Rebase to alpine linux 3.6.
+ **06.02.17:** Rebase to alpine linux 3.5.
+ **16.01.17:** Add packages required for replaygain.
+ **24.12.16:** Add [beets-copyartifacts](https://github.com/sbarakat/beets-copyartifacts) plugin.
+ **07.12.16:** Edit cmake options for chromaprint, should now build and install fpcalc, add gstreamer lib
+ **14.10.16:** Add version layer information.
+ **01.10.16:** Add nano and editor variable -
to allow editing of the config from the container command line.
+ **30.09.16:** Fix umask.
+ **24.09.16:** Rebase to alpine linux.
+ **10.09.16:** Add layer badges to README.
+ **05.01.16:** Change ffpmeg repository, other version crashes container
+ **06.11.15:** Initial Release
+ **29.11.15:** Take out term setting, causing issues with key entry for some users

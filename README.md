# beets

[Beets](http://beets.io) is the media library management system for
obsessive-compulsive music geeks.

![beets logo](https://github.com/thetarkus/docker-beets/raw/master/beet-150px.png)

**Fork**  
This is a fork of linuxserver/docker-beets.
This fork runs Python 3.
This fork pulls the latest master of Beets from GitHub.
This fork includes the `gmusicapi` pip package for the
[Gmusic Plugin](https://beets.readthedocs.io/en/v1.4.7/plugins/gmusic.html).

Be aware that this forks Dockerfile generates a larger image than the linuxserver image.  
Also, be aware that this container will take longer to build (due to pip building `lxml`).


## Usage

```
docker create \
    --name=beets \
    -v <path to config>:/config \
    -v <path to music>:/music \
    -v <path to non-processed music>:/import \
    -e PGID=<gid> -e PUID=<uid> \
    -p 8337:8337 \
    thetarkus/beets
```

## Parameters

* `-p 8337` - the port(s)
* `-v /config` - Configuration files
* `-v /music` - Music library location
* `-v /import` - Non-processed music
* `-e PGID` for GroupID
* `-e PUID` for UserID

For shell access whilst the container is running, run `docker exec -it beets sh`.


## Configuration

Initial run of the docker container will create the config files for you, if
they do not exist already.

Edit `config.yaml` in your /config directory.
To edit the config from within the container, run `beet config -e`.

When adding or removing the `web` plugin, you must restart the container.  
View all plugins and how to configure them at the
[beets docs](https://beets.readthedocs.io/en/v1.4.7/plugins/index.html).

Contains [beets-copyartifacts](https://github.com/sbarakat/beets-copyartifacts)
plugin, [configuration details](https://github.com/sbarakat/beets-copyartifacts#configuration)


## Commands

* To monitor the logs of the container in realtime `docker logs -f beets`.
* Import music `docker exec -it beets beet import /import"`


## Versions

+ **2018-08-14:** Use Beets master from GitHub instead of pip.
+ **2018-08-13:** Upgrade to python 3, alpine 3.8, mp3gain 1.6.2.
+ **2018-08-12:** Add requests pip package, add gmusicapi pip package.
+ **2018-03-04:** Upgrade mp3gain to 1.6.1.
+ **2018-01-02:** Deprecate cpu_core routine lack of scaling.
+ **2017-12-27:** Add beautifulsoup4 pip package.
+ **2017-12-06:** Rebase to alpine linux 3.7.
+ **2017-05-25:** Rebase to alpine linux 3.6.
+ **2017-02-06:** Rebase to alpine linux 3.5.
+ **2017-01-16:** Add packages required for replaygain.
+ **2016-12-24:** Add [beets-copyartifacts](https://github.com/sbarakat/beets-copyartifacts) plugin.
+ **2016-12-07:** Edit cmake options for chromaprint, should now build and install fpcalc, add gstreamer lib
+ **2016-10-14:** Add version layer information.
+ **2016-10-01:** Add nano and editor variable - to allow editing of the config from the container command line.
+ **2016-09-30:** Fix umask.
+ **2016-09-24:** Rebase to alpine linux.
+ **2016-09-10:** Add layer badges to README.
+ **2016-01-05:** Change ffpmeg repository, other version crashes container
+ **2015-11-06:** Initial Release
+ **2015-11-29:** Take out term setting, causing issues with key entry for some users


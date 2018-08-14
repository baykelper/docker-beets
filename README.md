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

For shell access whilst the container is running, run `docker exec -it beets sh`.


## Setting up the application

Edit the config file in /config

To edit the config from within the container use `beet config -e`

See [Beets](http://beets.io) for more info.

Contains [beets-copyartifacts](https://github.com/sbarakat/beets-copyartifacts) plugin, [configuration details](https://github.com/sbarakat/beets-copyartifacts#configuration)


## Info

* To monitor the logs of the container in realtime `docker logs -f beets`.

* Import music `docker exec -it beets sh -c "beet import /downloads"`


## Versions

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


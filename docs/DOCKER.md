> This is work in progress! readme is beta!  
> Status: It is serving gravel related tiles, but only on local host.  
> Main issues: Getting large pbf processed by osm2pgsql without running out of memory and crashing.  
> Tasks: Identify a Cloud provider, as I don't want to fuck around with nerdy linux installs and settings

# Running CyclOSM with Docker

[Docker](https://docker.com) is a virtualized environment running a [_Docker demon_](https://docs.docker.com/engine/docker-overview), in which you can run software without altering your host system permanently. The software components run in _containers_ that are easy to setup and tear down individually. The Docker demon can use operating-system-level virtualization (Linux, Windows) or a virtual machine (macOS, Windows).

This allows to set up a development environment for CyclOSM easily. Specifically, this environment consists of a
PostgreSQL database to store the OpenStreetMap data and [Kosmtik](https://github.com/kosmtik/kosmtik) for previewing the style.

## Prerequisites

Docker is available for Linux, macOS and Windows. [Install](https://www.docker.com/get-docker) the software packaged for your host system in order
to be able to run Docker containers. You also need Docker Compose, which should be available once you installed
Docker itself. Otherwise you need to [install Docker Compose manually](https://docs.docker.com/compose/install/).

You need sufficient disk space of _several Gigabytes_. Docker creates a disk image for its virtual machine that holds the virtualised operating system and the containers. The format (Docker.raw, Docker.qcow2, \*.vhdx, etc.) depends on the host system. It can be a sparse file allocating large amounts of disk space, but still the physical size starts with 2-3 GB for the virtual OS and grows to 6-7 GB when filled with the containers needed for the database, Kosmtik, and a small OSM region. Further 1-2 GB are needed for shape files in the cyclosm/data repository.

## Quick start

If you are eager to get started here is an overview over the necessary steps.
Read on below to get the details.

* `git clone https://github.com/limex/gravel-cartocss-style.git` to clone CyclOSM repository into a directory on your host system
* download OpenStreetMap data in osm.pbf format to a file `data.osm.pbf` and place it within the CyclOSM directory (for example some small area from [Geofabrik](https://download.geofabrik.de/))
* If necessary, `sudo service postgresql stop` to make sure you don't have currently running a native PostgreSQL server which would conflict with Docker's PostgreSQL server.
* `docker-compose up import` to import the data (only necessary the first time or when you change the data file)
* `docker-compose up kosmtik` to run the style preview application
* browse to [http://localhost:6789](http://localhost:6789) to view the output of Kosmtik
* Ctrl+C to stop the style preview application
* `docker-compose stop db` to stop the database container

_Note:_ You might encounter permissions issues if the `cyclosm-cartocss-style`
folder is not owned by the user with UID 1000. A quick workaround for this is
to `chown 1000:1000 cyclosm-cartocss-style` after cloning it.

## Repositories

Instructions above will clone main CyclOSM repository. To test your own changes you should [fork](https://help.github.com/articles/fork-a-repo/) cyclosm/cyclosm-cartocss-style repository and [clone your fork](https://help.github.com/articles/cloning-a-repository/).

This CyclOSM repository needs to be a directory that is shared between your host system and the Docker virtual machine. Home directories are shared by default; if your repository is in another place you need to add this to the Docker sharing list (e.g. macOS: Docker Preferences > File Sharing; Windows: Docker Settings > Shared Drives).

## Importing data

CyclOSM needs a database populated with rendering data to work. You first need a data file to import.
It's probably easiest to grab an PBF of OSM data from [Geofabrik](https://download.geofabrik.de/).
Once you have that file put it into the CyclOSM directory and run `docker-compose up import` in the CyclOSM directory.
This starts the PostgreSQL container (downloads it if it not exists) and starts a container that runs [osm2pgsql](https://github.com/openstreetmap/osm2pgsql) to import the data. The container is built the first time you run that command if it not exists.
At startup of the container the script `scripts/docker-startup.sh` is invoked which prepares the database and itself starts osm2pgsql for importing the data.

osm2pgsql has a few [command line options](https://manpages.debian.org/testing/osm2pgsql/osm2pgsql.1.en.html) and the import by default uses a RAM cache of 512 MB, 1 worker and expects the import file to be named `data.osm.pbf`. If you want to customize any of these parameters you have to set the environment variables `OSM2PGSQL_CACHE` (e.g. `export OSM2PGSQL_CACHE=1024` on Linux to set the cache to 1 GB) for the RAM cache (the value depends on the amount of RAM you have available, the more you can use here the faster the import may be), `OSM2PGSQL_NUMPROC` for the number of workers (this depends on the number of processors you have and whether your harddisk is fast enough e.g. is a SSD), or `OSM2PGSQL_DATAFILE` if your file has a different name.

You can also [tune the PostgreSQL](https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server) during the import phases, with `PG_WORK_MEM` (default to 16MB) and `PG_MAINTENANCE_WORK_MEM` (default to 256MB), which will eventually write `work_mem` and `maintenance_work_mem` to the `postgresql.auto.conf` once, making them applied each time the database started. Note that unlike osm2pgsql variables, once thay are set, you can only change them by running `ALTER SYSTEM` on your own, changing `postgresql.auto.conf` or remove the database volume by `docker-compose down -v && docker-compose rm -v` and import again.

If you want to customize and remember the values, supply it during your first import:

```
PG_WORK_MEM=128MB PG_MAINTENANCE_WORK_MEM=2GB \
OSM2PGSQL_CACHE=2048 OSM2PGSQL_NUMPROC=3 \
OSM2PGSQL_DATAFILE=taiwan.osm.pbf \
docker-compose up import
```

### Personal Notes:

OSM2PGSQL_CACHE is for the --cache parameter. Expected number, for MB (https://osm2pgsql.org/doc/manual.html)

Memory Considerations:
The amount of memory required depends on the size of your input OSM file. Whether you’re dealing with a city-sized extract or the entire planet, memory needs vary significantly.
**As a general guideline, you should have at least as much main memory (RAM) as the size of the PBF file containing the OSM data. For processing a planet file, a minimum of 64 GB RAM is recommended, although 128 GB is even better.
osm2pgsql won’t function with less than 2 GB RAM.**
Variables will be remembered in `.env` if you don't have that file, and values in the file will be applied unless you manually assign them.  
Depending on your machine and the size of the extract the import can take a while. When it is finished you should have the data necessary to render it with CyclOSM.

## Test rendering

After you have the necessary data available you can start Kosmtik to produce a test rendering. For that you run `docker-compose up kosmtik` in the CyclOSM directory. This starts a container with Kosmtik and also starts the PostgreSQL database container if it is not already running. The Kosmtik container is built the first time you run that command if it not exists.
At startup of the container the script `scripts/docker-startup.sh` is invoked and runs Kosmtik. If you have to customize anything, you can do so in the script. The Kosmtik config file can be found in `.kosmtik-config.yml`.
If you want to have a [local configuration](https://github.com/kosmtik/kosmtik#local-config) for our `project.mml` you can place a `localconfig.js` or `localconfig.json` file into the CyclOSM directory.

After startup is complete you can browse to [http://localhost:6789](http://localhost:6789) to view the output of Kosmtik. By pressing Ctrl+C on the command line you can stop the container. The PostgreSQL database container is still running then (you can check with `docker ps`). If you want to stop the database container as well you can do so by running `docker-compose stop db` in the CyclOSM directory.

## Troubleshooting

Importing the data needs a substantial amount of RAM in the virtual machine. If you find the import process (Reading in file: data.osm.pbf, Processing) being _killed_ by the Docker demon, exiting with error code 137, increase the Memory assigned to Docker (e.g. macOS: Docker Preferences / Windows: Docker Settings > Advanced > Adjust the computing resources).

Docker copies log files from the virtual machine into the host system, their [location depends on the host OS](https://stackoverflow.com/questions/30969435/where-is-the-docker-daemon-log). E.g. the 'console-ring' appears to be a ringbuffer of the console log, which can help to find reasons for killings.

While installing software in the containers and populating the database, the disk image of the virtual machine grows in size, by Docker allocating more clusters. When the disk on the host system is full (only a few MB remaining), Docker can appear stuck. Watch the system log files of your host system for failed allocations.

Docker stores its disk image by default in the home directories of the user. If you don't have enough space here, you can move it elsewhere. (E.g. macOS: Docker > Preferences > Disk).

## Updating OSM Data
According to [how-to-update-osm-data-using-osm2pgsql](https://gis.stackexchange.com/questions/191241/how-to-update-osm-data-using-osm2pgsql) delta updates are possible, but probably not effective. 

## Import Regions
osm.pbf for Europe is 28,3GB. It is probably better to personally select the needed countries, merge the file and import one file to postgis db. 

https://help.openstreetmap.org/questions/71934/osmconvert-errors-while-merging-maps-in-windows-10-unknown-file-format-could-not-open-input-file-osmpbf

Import to DB on i5 Core, 8GB:  
Austria (700MB): 4819s = 80min
France,Germany,Italy,Spain,Czech Republic,Austria,Switzerland,Slovakia,Slovenia,Hungary,Serbia,Croatia,Montenegro,Cyprus,Macedonia,Liechtenstein (17GB) = estimate = 28h

Import to DB on macbook pro:
Mallorca (37MB) 21s  
Austria (700MB): 4819s = 80min
France,Germany,Italy,Spain,Czech Republic,Austria,Switzerland,Slovakia,Slovenia,Hungary,Serbia,Croatia,Montenegro,Cyprus,Macedonia,Liechtenstein (17GB) = estimate = 28h



## Changes to original repo
Tiles show from Zoom 10 instead of 11 (pending)


## Notes

On Silicon Mac start the iTerm2 with Rosetta Support.


This guide is based on the
[`openstreetmap-carto`](https://github.com/gravitystorm/openstreetmap-carto/blob/master/DOCKER.md)
Docker guide.

##  Useful docker Commands
```
service docker status
sudo docker-compose up import
sudo docker-compose up kosmtik
sudo docker container list
sudo docker-compose stop db
sudo docker-compose stop kosmtik

# list all volumes and the sizes
sudo docker system df -v

# set Environment Variable to force amd64, even though it should already do b/c rosetta is set in Docker desktop
export DOCKER_DEFAULT_PLATFORM=linux/amd64

```

Set this values in the .env file for more performance and bigger pbf files:

```
PG_WORK_MEM=128MB
PG_MAINTENANCE_WORK_MEM=2GB
OSM2PGSQL_CACHE=8192
OSM2PGSQL_NUMPROC=3
OSM2PGSQL_DATAFILE=mallorca.osm.pbf
```


http://localhost:6789/cyclosm/tile/16/33342/24867.png
http://localhost:6789/cyclosm/tile/{z}/{x}/{y}.png

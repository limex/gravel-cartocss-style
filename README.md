## Disclaimer

> This is work in progress! Find the current challenges here [`docs/DOCKER.md`](docs/DOCKER.md).  
> Contact me via issue page if you wanna help.


OSM Gravel Layer
================

This is an attempt at creating a map layer showing roads suitable for "gravel" riding
(whatever that means, but people usually talk about wide tired drop bar bikes).
that can be rendered on top of any base map.

To do that, we forked [CyclOSM](https://github.com/cyclosm/cyclosm-cartocss-style) and
kept removing and changing styles until we arrived at something that suited our needs.
Kudos to them for the clean code structure and open sourcing their work!

## Licenses

This style is based on the [CyclOSM](https://github.com/cyclosm/cyclosm-cartocss-style),
which is licensed under BSD-3-Clause license. Everything (be it icons
or code) not listed explicitly below should be consider as available under
this license.

The contours and elevation lines render is based on the very good work and
code available from [OpenTopoMap](https://github.com/der-stefan/OpenTopoMap).

The colors used in the `palette.mss` file are based on the
[Hydda](https://github.com/karlwettin/tilemill-style-hydda/tree/bb27f0a9cad1920e19ae8febd39f6f9328369e6f)
style, licensed under Apache License 2.0.

The icons in `symbols/osm-bright-gl-style` are taken from the [OSM Bright GL
style](https://github.com/openmaptiles/osm-bright-gl-style/tree/327e1b41987893b958e3aae06abc2cc7363dc5aa/icons)
and are licensed under Creative Commons BY 4.0.

The icons in `symbols/openstreetmap-carto` are taken from the
[OpenStreetMap-carto](https://github.com/gravitystorm/openstreetmap-carto)
style and are licensed under CC0 public domain.

The icons in `symbols/osmandapp` are taken from the
[OsmAnd app resources](https://github.com/osmandapp/OsmAnd-resources).

The inner tube bicycle icon is based on
https://www.flaticon.com/free-icon/inner-tube_1575936.

---

> following readme is from the https://github.com/cyclosm/cyclosm-cartocss-style repo to give more context in config and running the docker container.

> This is work in progress. Most lines need to be deleted or changed.
---

Gravel Layer
=======

a [CartoCSS](https://carto.com/developers/styling/cartocss/) map style
designed with gravel cycling in mind. It leverages
[OpenStreetMap](https://www.openstreetmap.org/) data to create a beautiful and
practical overlay!

[![Build Status](https://api.travis-ci.org/cyclosm/cyclosm-cartocss-style.svg?branch=master)](https://travis-ci.org/cyclosm/cyclosm-cartocss-style)

> todo: insert pic of overlay. All gravel roads are as Red lines. 

## Demonstration

> Adapt to CX Berlin. If they are ever back again!  
> A demonstration of this style is available at [https://cyclosm.org](https://cyclosm.org).

The tile server url is
`https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png`. Tiles can
be reused under the general OpenStreetMap [tile usage
policy](https://operations.osmfoundation.org/policies/tiles/).

The map is available by default in the following smartphone applications:
- [OSMAnd](https://osmand.net/)
- [OpenMultiMaps](https://framagit.org/tom79/openmaps)
- [All-In-One Offline Maps](https://www.offline-maps.net) and [AlpineQuest Rando GPS](https://alpinequest.net)

The tile server is provided by
[OpenStreetMap-France](https://www.openstreetmap.fr), many thanks to them for
the support!

## Philosophy

> todo: adapt!

CyclOSM is a new cycle-oriented render. Contrary to
[OpenCycleMap](http://opencyclemap.org/), this render is free and open-source
software and aims at being more complete to take into account a wider
diversity of cycling habits.

In urban areas, it renders the main different types of cycle tracks and lanes,
on each side of the road, for helping you draw your bike to work route. It also
features essential POIs as well as bicycle parking spots or spots shared with
motorbikes, specific infrastructure (elevators / ramps), road speeds or
surfaces to avoid streets with pavings, bumpers and bike boxes, etc.

The same render also lets you visualize main bicycle touring routes as well as
essential POIs when touring (emergency services, shelters, tourism, shops).


## Features

> todo: adapt!

Render:

* Cycleways track, lanes, cycle-bus lanes
* Motor oneway - two way for bicycle
* Cycle routes (local, regional, national, international)
* Parking for bicycle (or motorcycle parking open to bicycle)
* Steps with bicycle friendly ramp
* Bicycle shop and repair stations
* First aid amenities : shelter, hospital, pharmacy, police station, water, food store
* Travel amenities : camping, hotel, train station, museum, picnic table, peaks...
* Emphasis on low speed roads (<= 30km/h)
* Elevation curves and shading
* Smoothness of the roads
* Traffic calming
* …

A full list of rendered features is available in [the
legend](https://www.cyclosm.org/legend.html).

A list of the tags considered by this render is available in [Taginfo JSON
format](https://wiki.openstreetmap.org/wiki/Taginfo/Projects) in [`taginfo.json`](taginfo.json).

Some extra information about the way OSM tags are rendered is available in
[the wiki](https://github.com/cyclosm/cyclosm-cartocss-style/wiki/Tag-to-Render).


## Getting started

> todo: adapt!

Getting started instructions are available in the [`docs/INSTALL.md`](docs/INSTALL.md) file.


## Printing

> todo: adapt!

Instructions for printing maps with a CyclOSM render are available in
the [`docs/PRINT.md`](docs/PRINT.md) file.


## Contributing

> todo: adapt!

Some getting started information for contributing is available in
[`CONTRIBUTING.md`](CONTRIBUTING.md) file.


## Changelog

> todo: adapt!

Changes to this theme are listed in the [`CHANGELOG.md`](CHANGELOG.md) file.
Versions are tagged with Git tags and are available through Github releases
feature.


## MapCSS validators

> todo: adapt!

We also offer some MapCSS checkers for bicycle tags which can be used with
[JOSM](https://josm.openstreetmap.de/wiki/Help/Preferences/Validator) for
instance in the [`validator`](validator) folder of this repository.


## Licenses

> todo: adapt!

See [`LICENSE.md`](LICENSE.md) file.

## Links

> todo: adapt!

* http://www.cyclosm.org, official website.
* http://www.cyclosm.org/legend.html, full detailed key.
* https://wiki.openstreetmap.org/wiki/CyclOSM, wiki page on the OSM wiki.
* A list of the tags considered by CyclOSM is available in [Taginfo JSON format](https://wiki.openstreetmap.org/wiki/Taginfo/Projects) in [`taginfo.json`](https://github.com/cyclosm/cyclosm-cartocss-style/blob/master/taginfo.json).


## Related projects

* An unofficial Docker image to deploy a CyclOSM tile server is available at https://github.com/mhajder/openstreetmap-tile-server-cyclosm.
* A gravel-oriented fork from CxBerlin is available at https://github.com/cxberlin/gravel-cartocss-style
* An high quality (especially DEM) tile server for Belgium is available from
    Champs-Libres, see https://www.champs-libres.coop/blog/post/2020-09-17-cyclosm/.

meta-pelux
==========
A Yocto/OpenEmbedded layer providing PELUX images. PELUX is a Linux based
platform used for developing automotive infotainment projects.

The layer provides the PELUX distro that is derived from poky. Furthermore,
this layer provides `core-image-pelux` recipes, along with necessary additions
to software components to enable a functional In-Vehicle Infotainment (IVI)
base image. The software component additions and appendments found in this
layer are specific for the PELUX image but can be used outside of this context.

Maintained at https://github.com/pelagicore/meta-pelux

Dependencies
------------
This layer depends on:

| meta layer          | git repo |
| ------------------- | -------- |
| poky                | https://git.yoctoproject.org/git/poky |
| meta-openembedded   | http://cgit.openembedded.org/meta-openembedded |
| meta-virtualization | https://git.yoctoproject.org/git/meta-virtualization |
| meta-bistro         | https://github.com/pelagicore/meta-bistro |
| meta-swupdate       | https://github.com/sbabic/meta-swupdate |

The relationship with `meta-bistro`, which is also developed at Pelagicore,
is that `meta-bistro` contains general software recipes and configurations,
aimed at the IVI domain, but no distribution and no images, whereas `meta-pelux`
builds on top of meta-bistro by adding a distro and recipes to build complete
system images.

Branching
---------
This repository will follow the Yocto release system. Whenever a new Yocto
release has been released, a new branch with the same name will be created from
the master branch.

All feature growth should happen first on the master branch,
but will also be cherry-picked back to the latest Yocto release branch.
Security and bug fixes will be evaluated case by case and backported as
necessary. The ambition is to actively maintain the two latest releases and/or
one-year-old releases in this fashion.

License and Copyright
---------------------
Copyright (C) 2016-2018 Pelagicore AB

All metadata is MIT licensed unless otherwise stated. Source code included in
tree for individual recipes is under the LICENSE stated in the associated
recipe (.bb file) unless otherwise stated.

License information for any other files is either explicitly stated or defaults
to MIT license.

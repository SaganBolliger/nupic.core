#!/bin/bash
# ----------------------------------------------------------------------
# Numenta Platform for Intelligent Computing (NuPIC)
# Copyright (C) 2013-5, Numenta, Inc.  Unless you have an agreement
# with Numenta, Inc., for a separate license for this software code, the
# following terms and conditions apply:
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as
# published by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# http://numenta.org/licenses/
# ----------------------------------------------------------------------

echo
echo Running before_deploy.sh...
echo

# If this branch is master, this is an iterative deployment, so we'll package
# wheels ourselves for deployment to S3. No need to build docs.
if [ "${TRAVIS_BRANCH}" = "master" ]; then

    # Upgrading pip
    sudo pip install --upgrade pip

    # Assuming pip 1.5.X is installed.
    echo "sudo pip install wheel"
    sudo pip install wheel

    # Wheel fails unless we remove this.
    sudo rm -rf external/linux32arm

    # Build all NuPIC and all required python packages into dist/wheels as .whl
    # files.
    export NUPIC_CORE_SRC="${TRAVIS_BUILD_DIR}/src"
    echo "pip wheel --wheel-dir=dist/wheels ."
    pip wheel --wheel-dir=dist/wheels . 
    # The dist/wheels folder is expected to be deployed to S3.

# If this is a tag, we're doing a release deployment, so we want to build docs
# for pypi...
else

    # For docs, direct people to numenta.org/docs/nupic.
    mkdir ./build/docs
    echo "<html><body>See NuPIC docs at <a href='http://numenta.org/docs/nupic/'>http://numenta.org/docs/nupic/</a>.</body></html>" > build/docs/index.html

fi




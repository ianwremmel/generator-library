#!/bin/bash

# Initialize git (if there isn't already a repo here)
git init

# Setup bower packages
./node_modules/.bin/bower prune
./node_modules/.bin/bower install

# Run updates for githooks
./node_modules/.bin/grunt githooks

#!/bin/sh

chef-solo -c solo.rb -j node_${1}.json


#!/usr/bin/env bash

open https://github.com/perusio/nginx-hello-world-module

#  Static Module : ./configure (...) --add-module=/path/to/hello-world-module
#  Dynamic Module: ./configure (...) --add-dynamic-module=/path/to/hello-world-module

# Configure the module. There's only one directive hello_world that is supported in the location context only.

#  Example:
#
#  location = /test {
#
#     hello_world;
#
#  }
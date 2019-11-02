#!/bin/bash

grep -rnw '/root/.ros/log' -e 'Traceback' > /dev/null && exit 1 || exit 0
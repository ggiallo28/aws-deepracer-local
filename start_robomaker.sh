#!/bin/sh

. ./configure_env.sh
docker run --rm --name dr --env-file ./source/robomaker.env --network sagemaker-local -p 8080:5900 -it crr0004/deepracer_robomaker:console
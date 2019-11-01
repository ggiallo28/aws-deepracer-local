#!/bin/sh

. ./configure_env.sh
sed -e 's/REPLACE/'$MYIP'/g' robomaker.env.dumps > robomaker.env
docker run --rm --name dr --env-file ./robomaker.env --network sagemaker-local -p 8080:5900 -it crr0004/deepracer_robomaker:console
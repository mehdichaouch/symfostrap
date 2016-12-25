#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo >&2 "You must supply an argument to start: prod|test|dev"
    echo >&2 "                            to stop:  stop"
    exit 1
fi

################################################################################

function serverStatus {
    php bin/console server:status
}

################################################################################

if [[ ("$1" == 'prod' || $1 == 'test' || $1 == 'dev') ]]; then
  # http://symfony.com/doc/current/cookbook/web_server/built_in.html
  php bin/console server:start --env=$1
  sleep 2

  # http://symfony.com/doc/current/cookbook/deployment/tools.html
  ## Clear your Symfony CacheClear your Symfony Cache
  php bin/console cache:clear --env=$1 --no-debug
  ## Dump your Assetic AssetsDump your Assetic Assets
  php bin/console assetic:dump --env=$1 --no-debug
fi

if [[ ("$1" == 'stop') ]]; then
  php bin/console server:$1
fi

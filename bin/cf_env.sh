#!/bin/bash

export SCRIPT="$( basename "${BASH_SOURCE[0]}" )"
export SCRIPTPATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export WORKSPACE=${WORKSPACE:-$SCRIPTPATH/../workspace}

CF_ADMIN_PASSWORD=$(bosh int $WORKSPACE/deployment-vars.yml --path /cf_admin_password)  
export CF_ADMIN_PASSWORD=${CF_ADMIN_PASSWORD:-'admin'}
export UAA_ADMIN_CLIENT_SECRET=$(bosh int $WORKSPACE/deployment-vars.yml --path /uaa_admin_client_secret)  

SYSTEM_DOMAIN=${SYSTEM_DOMAIN:-"bosh-lite.com"}
CF_API_DOMAIN=${CF_API_DOMAIN:-"api.$SYSTEM_DOMAIN"}

cf api https://$CF_API_DOMAIN --skip-ssl-validation
cf auth admin $CF_ADMIN_PASSWORD  

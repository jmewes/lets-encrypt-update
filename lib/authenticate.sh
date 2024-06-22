#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

#
# CERTBOT_DOMAIN: The domain being authenticated
# CERTBOT_VALIDATION: The validation string
# CERTBOT_TOKEN: Resource name part of the HTTP-01 challenge (HTTP-01 only)
# CERTBOT_REMAINING_CHALLENGES: Number of challenges remaining after the current challenge
# CERTBOT_ALL_DOMAINS: A comma-separated list of all domains challenged for the current certificate
#
# https://eff-certbot.readthedocs.io/en/stable/using.html#hooks
#

echo "########################################################"
echo "CERTBOT_DOMAIN: ${CERTBOT_DOMAIN}"
echo "CERTBOT_VALIDATION: ${CERTBOT_VALIDATION}"
echo "CERTBOT_TOKEN: ${CERTBOT_TOKEN}"
echo "CERTBOT_REMAINING_CHALLENGES: ${CERTBOT_REMAINING_CHALLENGES}"
echo "CERTBOT_ALL_DOMAINS: ${CERTBOT_ALL_DOMAINS}"

${SCRIPT_DIR}/ftp-upload.py -c"${CERTBOT_VALIDATION}"

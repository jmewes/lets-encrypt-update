#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

###############################################################################
# Handle script parameters
###############################################################################

function usage()
{
    cat <<-END
usage: create_certificate.sh -d DOMAINS -e EMAIL [-h]

required arguments:
  -d    A comma-separated list of domains, e.g. example.com,www.example.com,example.de,www.example.de
  -e    The email adress to be used for the Let's Encrypt account, e.g. johndoe@example.com

optional arguments:
  -h    Show this help message and exit.

required environment variables:
  FTP_HOST  The host of the FTP server, e.g. 161.35.213.167
  FTP_USER  The name of a user that has the permission to upload files on the FTP server, e.g. user
  FTP_PASSWORD  The password which authenticates the user identified with FTP_USER

dependencies:
  - certbot
  - python3
END
}

while getopts "h d: e:" o; do
  case "${o}" in
    d)
      DOMAINS=${OPTARG}
      ;;
    e)
      EMAIL=${OPTARG}
      ;;
    h | *)
      usage
      exit 0
      ;;
  esac
done
shift $((OPTIND-1))

if [[ -z "${DOMAINS}" ]] ; then
  echo -e "ERROR: Missing required parameter '-d'.\n" >&2
  usage
  exit 1
fi

if [[ -z "${EMAIL}" ]] ; then
  echo -e "ERROR: Missing required parameter '-e'.\n" >&2
  usage
  exit 1
fi

if [[ -z "${FTP_HOST}" ]] ; then
  echo -e "ERROR: Missing required environment variable 'FTP_HOST'.\n" >&2
  usage
  exit 1
fi

if [[ -z "${FTP_USER}" ]] ; then
  echo -e "ERROR: Missing required environment variable 'FTP_USER'.\n" >&2
  usage
  exit 1
fi

if [[ -z "${FTP_PASSWORD}" ]] ; then
  echo -e "ERROR: Missing required environment variable 'FTP_PASSWORD'.\n" >&2
  usage
  exit 1
fi

###############################################################################
# Test dependencies
###############################################################################

which certbot > /dev/null || { echo "ERROR: certbot not installed" ; exit 1 ; }
which python3 > /dev/null || { echo "ERROR: python3 not installed" ; exit 1 ; }

###############################################################################
# Main
###############################################################################

cd $(mktemp -d)

for d in $(echo $DOMAINS | tr ',' '\n') ; do
  DOMAIN_ARGS="${DOMAIN_ARGS} --domain $d"
done

certbot certonly \
  --manual \
  --manual-auth-hook ${SCRIPT_DIR}/lib/authenticate.sh \
  --config-dir . --work-dir . --logs-dir . \
  ${DOMAIN_ARGS} \
  --email "${EMAIL}" \
  --non-interactive \
  --agree-tos \

find .

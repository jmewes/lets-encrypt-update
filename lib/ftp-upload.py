#!/usr/bin/env python3

# https://docs.python.org/3/library/ftplib.html

import ftplib
import tempfile
import argparse
import os

if __name__ == "__main__":
  parser = argparse.ArgumentParser()
  # TODO Rename argument to CERTBOT_VALIDATION
  parser.add_argument("-c", "--challenge", help='HTTP-01 Challenge token', type=str, required=True)
  args = parser.parse_args()

  ftp = ftplib.FTP(os.environ['FTP_HOST'], os.environ['FTP_USER'], os.environ['FTP_PASSWORD'])

  temp = tempfile.TemporaryFile()
  temp.write(args.challenge.encode())
  temp.seek(0)

  try:
      ftp.cwd('.well-known/acme-challenge')
  except:
      ftp.mkd('.well-known')
      ftp.cwd('.well-known')
      ftp.mkd('acme-challenge')
      ftp.cwd('acme-challenge')

  filename = args.challenge.split(".")[0]

  ftp.storbinary('STOR %s' % filename, temp)

  temp.close()
  ftp.close()

#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
LOCALPATH=/minio/output

if [ $github_version != $ftp_version ] && [ ${dist_version} == "2020-09-10T22-02-45Z" ]
then
  git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
  cd repository-scrips/
  chmod +x empacotar-deb.sh
  chmod +x empacotar-rpm.sh
  sudo mv empacotar-deb.sh ..$LOCALPATH
  sudo mv empacotar-rpm.sh ..$LOCALPATH
  cd ..$LOCALPATH
  sudo ./empacotar-deb.sh minio minio_ppc64le_$github_version $github_version " "
  sudo ./empacotar-rpm.sh minio minio_ppc64le_$github_version $github_version " " "MinIO is a High Performance Object Storage released under Apache License v2.0. It is API compatible with Amazon S3 cloud storage service. Use MinIO to build high performance infrastructure for machine learning, analytics and application data workloads."
fi
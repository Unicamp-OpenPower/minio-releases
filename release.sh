#!/usr/bin/env bash
github_version=$(cat github_version.txt)
ftp_version=$(cat ftp_version.txt)
ROOTPATH="~/rpmbuild/RPMS/ppc64le"
LOCALPATH=/home/travis/gopath/minio/minio-$github_version
REPO1="/repository/debian/ppc64el/minio"
REPO2="/repository/rpm/ppc64le/minio"

if [ "$github_version" != "$ftp_version" ]
  then
    git clone https://$USERNAME:$TOKEN@github.com/Unicamp-OpenPower/repository-scrips.git
    cd repository-scrips/
    chmod +x empacotar-deb.sh
    chmod +x empacotar-rpm.sh
    sudo mv empacotar-deb.sh ..$LOCALPATH
    sudo mv empacotar-rpm.sh ..$LOCALPATH
    cd ..$LOCALPATH
    sudo ./empacotar-deb.sh minio minio-$github_version $github_version " "
    sudo ./empacotar-rpm.sh minio minio-$github_version $github_version " " "MinIO is a High Performance Object Storage released under Apache License v2.0. It is API compatible with Amazon S3 cloud storage service. Use MinIO to build high performance infrastructure for machine learning, analytics and application data workloads."
fi

if [[ $github_version > $ftp_version ]]
   then
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO1 $LOCALPATH/minio-$github_version-ppc64le.deb"
        sudo lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O $REPO2 $ROOTPATH/minio-$github_version-1.ppc64le.rpm"
fi

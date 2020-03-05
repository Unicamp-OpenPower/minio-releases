#github_version=$(cat github_version.txt)
#ftp_version=$(cat ftp_version.txt)
github_version=2020-02-07T04-56-50Z
#ftp_version=2019-12-30T05-45-39Z
del_version=$(cat delete_version.txt)

if [ "$github_version" != "$ftp_version" ]
then
    cd /home/travis/gopath
    mkdir github.com
    cd github.com
    mkdir minio
    cd minio
    wget https://github.com/minio/minio/archive/RELEASE.$github_version.zip
    unzip RELEASE.$github_version.zip
    mv minio-RELEASE.$github_version minio
    cd minio
    #sudo sh -c 'echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6'
    make
    ./minio
    mv minio minio-$github_version
    
    if [[ "$github_version" > "$ftp_version" ]]
    then
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minio/latest minio-$github_version"
        lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minio/latest/minio-$ftp_version" 
    fi
    lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; put -O /ppc64el/minio minio-$github_version"
    #lftp -c "open -u $USER,$PASS ftp://oplab9.parqtec.unicamp.br; rm /ppc64el/minio/minio-$del_version" 
fi

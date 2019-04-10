import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/minio/minio/releases/latest')
    .content)
index = html.find('commits')
github_version = html[index + 16:index + 36]
file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

# find and save the current Bazel version on FTP server
html = str(
    requests.get(
        'https://oplab9.parqtec.unicamp.br/pub/ppc64el/minio/'
    ).content)
index = html.rfind('minio-')
ftp_version = html[index + 6:index + 26]
file = open('ftp_version.txt', 'w')
file.writelines(ftp_version)
file.close()

# find and save the oldest Bazel version on FTP server
index = html.find('minio-')
delete = html[index + 6:index + 26]
file = open('delete_version.txt', 'w')
file.writelines(delete)
file.close()

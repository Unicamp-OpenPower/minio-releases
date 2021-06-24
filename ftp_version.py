import requests
# find and save the current Github release
html = str(
    requests.get('https://github.com/minio/minio/releases/latest')
    .content)
index = html.find('RELEASE.')
github_version = html[index + 8:index + 28]
# vai trocar o caracter "-" pelo caracter "." . EX: 2020-09-10T22-02-45Z -> 2020.09.10T22.02.45Z  
github_version2=github_version.replace("-",".")

file = open('github_version.txt', 'w')
file.writelines(github_version)
file.close()

f = open('github_version2.txt', 'w')
f.writelines(github_version2)
f.close()

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

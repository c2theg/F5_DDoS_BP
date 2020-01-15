<h2>Quick Setup</h2>
**2 Options**

- 1) use "download_git_repo.sh"
```
curl -k -O https://raw.githubusercontent.com/c2theg/F5_DDoS_BP/master/download_git_repo.sh && chmod u+x download_git_repo.sh
```

- 2) Create a script on the BigIP to download the Git repo
```
    #!/bin/sh
    curl -k -O -H 'Accept: application/vnd.github.v3.raw' -O -L https://github.com/c2theg/F5_DDoS_BP/archive/master.zip
    unzip master.zip
    cd F5_DDoS_BP-master/
    ls -ltrh
```

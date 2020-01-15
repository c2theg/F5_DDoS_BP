# F5_DDoS_BP
DDoS Best Practices


<h2>Quick Setup</h2>
2 Options
1) use "download_git_repo.sh"
    -> curl https://raw.githubusercontent.com/c2theg/F5_DDoS_BP/master/download_git_repo.sh

2) Create a script on the BigIP to download the Git repo
<blockquote>
    #!/bin/sh
    curl -k -O -H 'Accept: application/vnd.github.v3.raw' -O -L https://github.com/c2theg/F5_DDoS_BP/archive/master.zip
    unzip master.zip
    cd F5_DDoS_BP-master/
    ls -ltrh
</blockquote>

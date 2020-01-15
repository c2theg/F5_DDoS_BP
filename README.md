<h2>Quick Setup</h2>

- Use the One-line method, (using "download_git_repo.sh")
```
curl -k -O https://raw.githubusercontent.com/c2theg/F5_DDoS_BP/master/download_git_repo.sh && chmod u+x download_git_repo.sh && ./download_git_repo.sh
```

From the output, you will be given the dir list of all files. These files provide use-cases which you might want to deploy your BigIP.

To provide the generic foundation for the config, run:
```
    firstTimeSetup.sh
```

This script sets the following:
```
- logout
- DNS and NTP Servers
- VLans
- Self IP's
- SNMP (basic)
- Message of the Day (Legal verbage) - for both WebUI and CLI
- PVA Compatibility
- Port lists
- Address Lists
- Logging
```

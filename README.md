<h1>Quick Setup</h1>

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
- Logout
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

<h1>Use case based Setup's</h1>

<h2>DDoS</h2>
This is for the following use-cases
1) Inline
2) Out of Path
3) Span * (Work in progress)

```
    firstTimeSetup_ddos.sh
```
This script sets the following DDoS specific area's:
```
- Log Publisher (Security Settings)
- Sets various db variables
- Address and Port Lists
- IP-Intelligence (Black & White list categories)
- IP-Intelligence Address Feeds (External Feed lists)
- Traffic Groups
- Eviction Policies
- TCP, UDP, IPOther - Policies
- Timer Policy
- Port Misuse Policy
- Service Policy
- Firewall - Rule Lists
- Firewall - DDoS Policy
- Sets Global Firewall Policy
- Fast Layer 4 (fast_l4) Profile
- DDoS (Device Level) profile
- DDoS (Generic)
- DDoS DNS profile
- IPS (Intrusion Pretection Service) DDoS profile
- Example LTM Virtual Servers  (Security Focused)
```


<h2>ADC</h2>

Run the following script:
```
    firstTimeSetup_adc.sh
```

This script sets the following DDoS specific area's:
```
- TCP Profile - Optimized for Data Center traffic (BBR congestion-control configured)
- HTTP Profile - Optimized for Mobile users
```


<h2>Fresh Start</h2>
Run the following script:
```
    firstTimeSetup_reset.sh
```
Will reset the BigIP to the default config and reboot it. This <u>WILL NOT unlicense it!</u>

<h2>Provision</h2>
Run the following script:
```
    firstTimeSetup_provision.sh
```
This will provision the BigIP for a DDoS usecase. The script also provides examples on how it can be modified to change that usecase. <i>Others might be included in the future. </i>

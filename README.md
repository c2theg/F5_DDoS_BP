<h1>Quick Setup</h1>

- Use the One-line method, (using "download_git_repo.sh")
```
curl -k -O https://raw.githubusercontent.com/c2theg/F5_DDoS_BP/master/download_git_repo.sh && chmod u+x download_git_repo.sh && ./download_git_repo.sh
```


<h3>Troubleshooting</h3>
If you get "<b>curl: (6) Could not resolve host: raw.githubusercontent.com</b>", issue the following command in TMSH: 

```
tmsh modify sys dns name-servers add { 208.67.220.220 9.9.9.9 1.1.1.1 8.8.8.8 2620:119:35::35 2001:4860:4860::8888 }
```

<h4>UDF</h4>
If you are configuring a machine in UDF, run the following to exit TMOS without closing the session

```
run /util bash
```

From the output, you will be given the dir list of all files. These files provide use-cases which you might want to deploy your BigIP.

To provide the generic foundation for the config, run:
```
    ./firstTimeSetup.sh
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
    ./firstTimeSetup_ddos.sh
```
This script sets the following DDoS specific area's:
```
- Log Publisher (Security Settings)
- GRE Tunnel (Anycast)
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
    ./firstTimeSetup_adc.sh
```

This script sets the following DDoS specific area's:
```
- TCP Profile - Optimized for Data Center traffic (BBR congestion-control configured)
- HTTP Profile - Optimized for Mobile users
- HTTP-Compression Profile - Sets numerious GZip settings, and includes all common text formats used on the web. 
- HTTP Specific DDoS Profile
- Example Web Application / Microservice (Performance & Security Focused)
```


<hr />

<h2>Fresh Start</h2>

Run the following script:
```
    ./firstTimeSetup_reset.sh
```
Will reset the BigIP to the default config and reboot it. This <b><u>WILL NOT unlicense it!</u></b> But you will have to re-provision the BigIP afterwards.


<h2>Provisioning</h2>

<b>DDoS</b>

This will provision the BigIP for a DDoS usecase. Run the following script:
```
    ./firstTimeSetup_provision_DDoS.sh
```

<b>ASM (Web Application Firewall)</b>

This will provision the BigIP for a Web Application Firewall usecase.  Run the following script:
```
    ./firstTimeSetup_provision_ASM.sh
```

These scripts also provide examples on how it can be modified to change the usecase. <i>Others might be included in the future. </i>

<hr />


Almost All are UDP based
+------------------------+--------------------------------+------------------------------+----------+
|        Protocol        | Bandwidth Amplification Factor |      Vulnerable Command      |  Port(s) |
+------------------------+--------------------------------+------------------------------+----------+
| DNS                    | 28 to 54                       | see: TA13-088A               |    53    |
| NTP                    | 556.9                          | see: TA14-013A               |    123   |
| SNMPv2                 | 6.3                            | GetBulk request              |    161   |
| NetBIOS                | 3.8                            | Name resolution              |    137   |
| SSDP                   | 30.8                           | SEARCH request               |    1900  |
| CharGEN                | 358.8                          | Character generation request |    19    |
| QOTD                   | 140.3                          | Quote request                |    17    |
| BitTorrent             | 3.8                            | File search                  |   6881   |
| Kad                    | 16.3                           | Peer list exchange           |   751    |
| Quake Network Protocol | 63.9                           | Server info exchange         |   26000  |
| Steam Protocol         | 5.5                            | Server info exchange         |   27015  |
| Multicast DNS (mDNS)   | 2 to 10                        | Unicast query                |   5353   |
| RIPv1                  | 131.24                         | Malformed request            |   520    |
| Portmap (RPCbind)      | 7 to 28                        | Malformed request            |   111    |
| LDAP                   | 46 to 55                       | Malformed request            |   389 T  |
| CLDAP                  | 56 to 70                       | —                            |   389    |
| TFTP                   | 60                             | —                            |   69     |
| Memcached              | 10,000 to 51,000               | —                            |  11211   |
| WS-Discovery           | 15,000                         | —                            | 139,445  |
|                        |                                | —                            |1124, 3702|
| Apple Remote Desktop   | 35.5                           | -                            |   3283   |
| Windows Remote Desktop |                                |                              |          |
|  Gateway (RD Gateway)  |                                |                              |   3391   |
+------------------------+--------------------------------+------------------------------+----------+
 worst ports:  11211 3702 3702 123 19 17 520 
    - 11211 3702 123 19
    - Memcache, WS-Discovery, NTP, CharGEN
    

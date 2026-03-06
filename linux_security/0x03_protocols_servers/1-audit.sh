#!/bin/bash
sudo grep -Ev '^\s*#|^$' /etc/ssh/sshd_config

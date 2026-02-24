#!/bin/bash
echo "SELinux status:                 $(getenforce 2>/dev/null || echo disabled)"

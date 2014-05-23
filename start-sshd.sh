#!/bin/bash
echo "Startting sshd..."
exec /usr/sbin/sshd -D 
echo "Sshd started"

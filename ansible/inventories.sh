#!/bin/bash


yc compute instances list |   head -n5 | tail -n2 | awk -F "|" '{gsub (" ", "", $0); gsub ("reddit-",  "", $0); print "["$3"]\n" $3"server"  " ansible_host="$6}' > inventory
ansible-inventory -i inventory --list > inventory.json

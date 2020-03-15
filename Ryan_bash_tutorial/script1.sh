#!/bin/bash
# name: script1.sh

# scope 1 demo
var1=blach
var2=foo

# verify values by printing them out
echo $0 :: var1 : $var1, var2 : $var2
echo both vars print out when echoed bc they were created in this script

# export var 1 to be able to use in other places
export var1
echo var1 exported

# run script 2
./script2.sh

#what do they look like after export?
echo $0 :: var1 : $var1, var2 : $var2


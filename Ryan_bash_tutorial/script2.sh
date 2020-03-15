#!/bin/bash
# name: script2.sh
# demo variable scope 2

# verify current values

echo $0 :: var 1 : $var1, var2 : $var2
echo because var2 was not exported in original script, it will not print out

# change values:
var1=floop
var2=blegh

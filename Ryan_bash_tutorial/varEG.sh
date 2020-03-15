#!/bin/bash
# varEG.sh 
# working with var's

#set values of 2 diff var's 
myvar=YoEarth
another=Ferdy

# run the var's to see that they print (is redundant)
echo $myvar $another

# set var: path to directory /etc
echo
sampledir=/etc

# runs ls for that var
ls $sampledir

# command substitution: 
myvar=$( ls /etc | wc -l)
# this pipes the wc -l (# line count) into the ls /etc output,
# and saves it as myvar

# exporting var's
# scope 1 demo
var1=blacj
var2=foo

# verify values
echo $0 :: var1 : $var1, var2 : $var2

export var1
./script2.sh

echo var1 exported

#what do they look like after export?
echo $0 :: var1 : $var1, var2 : $var2












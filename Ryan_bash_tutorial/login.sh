#!/bin/bash
#name: login.sh

# ask user for login deets

# allows a prompt next to user input
read -p 'username: ' uservar

#allows prompt (p) and silences input (s)
read -sp 'Password ' passvar


echo
echo thanks $uservar, we now have your login deets

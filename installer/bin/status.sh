#!/bin/bash

########################################################
# T-Pot Community Edition                              #
# Container and services status script                 #
#                                                      #
# v0.10 by mo, DTAG, 2015-01-27                        #
########################################################
myCOUNT=1
while true
do 
  if ! [ -f /var/run/check.lock ];
    then break
  fi
  sleep 0.1
  if [ $myCOUNT = 1 ];
    then
      echo -n "Waiting for services "
    else echo -n .
  fi
  myCOUNT=$[$myCOUNT +1]
done
echo
echo
echo "****************** $(date) ******************"
echo
echo
for i in dionaea elk ews glastopf honeytrap kippo suricata
do 
  echo "======| Container:" $i "|======"
  docker exec -i $i supervisorctl status | GREP_COLORS='mt=01;32' egrep --color=always "(RUNNING)|$" | GREP_COLORS='mt=01;31' egrep --color=always "(STOPPED|FATAL)|$"
  echo
done

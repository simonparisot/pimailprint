#!/bin/bash
MAILDIR=/home/pi/pimailprint/maildata
# Enable logs
LOG=/dev/null
#LOG=/home/pi/pimailprint/logs/printmail.log
ATTACH_DIR=/home/pi/pimailprint/attachments

fetchmail -f /home/pi/pimailprint/fetchmail.conf

# test if some mails have been fetched
if [ -n "$(ls -A $MAILDIR/new)" ]; then
  date +%r-%-d/%-m/%-y >> $LOG
  echo "New mail detected, let's work" >> $LOG
  shopt -s nullglob #used to avoid looping over an empty folder
  for i in $MAILDIR/new/*
  do
    echo "Processing $i" >> $LOG
    uudeview "$i" -i -p $ATTACH_DIR/ 
    for x in $ATTACH_DIR/*
    do
      echo "$x found! Printing now..." >> $LOG
      lp "$x" >> $LOG
    done
    rm $ATTACH_DIR/* >> $LOG
    rm $i >> $LOG
  done
  shopt -u nullglob
echo "Alright folks, job's done" >> $LOG
fi

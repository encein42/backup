#!/bin/sh
## backup_now.sh for backup in /home/ungaro_l/myscripts
## 
## Made by Luca Ungaro
## Login   <ungaro_l@epitech.net>
## 
## Started on  Wed Jan 27 14:50:32 2016 Luca Ungaro
## Last update Wed Jan 27 15:56:32 2016 Luca Ungaro
##

CP="cp --no-dereference --preserve=links --recursive"
TEE="tee --append"
DRIVE=/run/media/$USER/EPI-BACKUP
BACKUP=$DRIVE/backup
ERRLOG=$BACKUP/backup.log

DEFAULT="\033[00m"
GREEN="\033[0;32m"
RED="\033[0;31m"
TEAL="\033[1;36m"

TARGETS=(
    ~/.my*
    ~/.bashrc
    ~/.zshrc
    ~/.emacs*
    ~/.config/
    ~/.froot/
    ~/.ssh/
    ~/rendu/
    ~/myscripts/
    ~/perso/
    )

echerr()
{
    echo $@ 1>&2;
}

if [ -d $DRIVE  ]
then
    if [ ! -d $BACKUP ]
    then
	mkdir $BACKUP
    fi
    cd $BACKUP

    echo -e "\nStarting backup : destination is $TEAL $BACKUP $DEFAULT\n"
    echo -e "\n\t---- BACKUP STARTED AT `date` ----\n" >> $ERRLOG

    for ITEM in ${TARGETS[@]}
    do
	$CP $ITEM $BACKUP 2>> $ERRLOG \
	&& echo -e "[ $GREEN OK $DEFAULT ] $ITEM" | $TEE $ERRLOG \
	|| echo -e "[ $RED !LINKS $DEFAULT ] $ITEM" | $TEE $ERRLOG
    done

    echo -e "\n\t---- BACKUP ENDED AT `date` ----\n" >> $ERRLOG
    echo "--------------------------------------------------------------------------------" >> $ERRLOG
    echo -e "\nDone backup : errlog in $TEAL $ERRLOG $DEFAULT\n"

else
    echerr "Drive '$DRIVE' not found...";
fi

#!/bin/bash
# author: Richard .V Martins Tenorio
# description: uninstall all adobe suite (2019-05-13)

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
cmd='ls /Applications/ | grep Adobe';
list=$(eval $cmd);

echo "[removing all adobe applications ...]";
for row in $list; do
  echo "App to remove : $row";
  if [[ "$row" =~ \.app$ ]]; then
    sudo rm -rf $row;
    echo "no link found for - $row - only file to remove"
    continue
  else
    for file in $(mdfind -name "$row"); do
      sudo rm -rf $file
      echo "File linked to app to remove : $file";
    done
  fi
done


echo "[removing Adobe Create Cloud ...]"
for file in $(mdfind -name "Adobe Creative Cloud"); do
  sudo rm -rf $file
  echo "File linked to app to remove : $file";
done


IFS=$SAVEIFS

echo '[Process completed ...]';

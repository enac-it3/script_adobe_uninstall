#!/bin/bash
# author: Richard .V Martins Tenorio
# description: uninstall useless application after lastest (2018-01-08) adobe epfl suite installation

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
cmd='ls /Applications/ | grep Adobe';
list=$(eval $cmd);
files_to_rm=();

for row in $list; do
  if [ "$row" = "Adobe" ] || [ "$row" = "Adobe Photoshop CC 2018" ] || [ "$row" = "Adobe Illustrator CC 2018" ] || [ "$row" = "Adobe InDesign CC 2018" ] || [ "$row" = "Adobe Acrobat 2015" ] || [ "$row" = "Adobe Acrobat 2017" ];then
    echo "keeping : $row";
    continue
  else
    echo "App to remove : $row";
    if [[ "$row" =~ \.app$ ]]; then
      sudo rm -rf "Adobe\ Scout\ CC.app/";
      echo "no link found for - $row - but removed it"
      continue
    else
      for file in $(mdfind -name "$row"); do
        sudo rm -rf $file
        echo "File linked to app to remove : $file";
      done
    fi
  fi
done

IFS=$SAVEIFS

echo '[Process completed ...]';

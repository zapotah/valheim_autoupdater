#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

verbose=0

get_versions()
{
  publicversion=$(sudo -u valheim curl -s "https://api.steamcmd.net/v1/info/896660" | cat | jq '.data["896660"].depots.branches.public.buildid' -r | tr -d '\n')
  installedversion=$(sudo -u valheim grep "buildid" /opt/valheim/valheimserver/steamapps/appmanifest_896660.acf | awk '{print $2}' | sed 's/"//g' | tr -d '\n')
  if  [ $verbose = 1 ]; then
    echo "Release version:" $publicversion
    echo "Installed version:" $installedversion
  fi
}

update_valheim()
{
  if [ $publicversion -gt $installedversion ]; then
    if [ $verbose = 1 ]; then
      echo "Update required"
    fi
    systemctl stop valheimserver.service
    if [ $verbose = 1 ]; then
      sudo -H -u valheim bash -c '/usr/games/steamcmd +force_install_dir /opt/valheim/valheimserver +login anonymous +app_update 896660 validate +exit'
    else
      sudo -H -u valheim bash -c '/usr/games/steamcmd +force_install_dir /opt/valheim/valheimserver +login anonymous +app_update 896660 validate +exit' > /dev/null
    fi
    systemctl start valheimserver.service
  fi
}

get_versions
update_valheim

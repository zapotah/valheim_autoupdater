# Valheim autoupdater
A really naive short autoupdater script for valheim dedicated server. Run via cron as root and set permissions of the script to root:root 750 so that it cannot be modified by the server user.

This assumes the server runs as the "valheim" user, change sudo references to whatever yours runs as.

This also assumes the gameserver is installed at /opt/valheim/valheimserver/ , change to where ever your installation is at.

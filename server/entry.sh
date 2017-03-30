#!/bin/sh

cat <<'EOF'

 _____          _             _       
|  ___|_ _  ___| |_ ___  _ __(_) ___  
| |_ / _` |/ __| __/ _ \| '__| |/ _ \ 
|  _| (_| | (__| || (_) | |  | | (_) |
|_|  \__,_|\___|\__\___/|_|  |_|\___/ 
                                      
       ____    ____  _____           _____ 
__   _|___ \  |___ \|___ /       _ _|___ / 
\ \ / / __) |   __) | |_ \ _____| '__||_ \ 
 \ V / / __/ _ / __/ ___) |_____| |  ___) |
  \_/ |_____(_)_____|____/      |_| |____/ 
                                           
EOF

FACTORIO="/opt/factorio/bin/x64/factorio"

# Server Name
NAME=${NAME:-Factorio Server ${FACTORIO_VERSION}}

# Server Description
DESCRIPTION=${DESCRIPTION:-Factorio Server running in docker}

# Savegame
if [ $# -gt 0 ]
then
    SAVEGAME=$1.zip
else
    SAVEGAME=save.zip
fi

# Verify Users Identity
VERIFY_IDENTITY=${VERIFY_IDENTITY:-false}

# Max players
MAX_PLAYERS=${MAX_PLAYERS:-0}

# Password
GAME_PASSWORD=${GAME_PASSWORD:-}

# Lan Visibility
LAN_VISIBILITY=${LAN_VISIBILITY:-true}

# Public Visibility
PUBLIC_VISIBILITY=${PUBLIC_VISIBILITY:-false}

# User Token
USER_TOKEN=${USER_TOKEN:-}

# RCON Password
RCON_PASSWORD=${RCON_PASSWORD:-$(cat /dev/urandom | tr -dc 'a-f0-9' | head -c16)}

# Auto Pause
AUTO_PAUSE=${AUTO_PAUSE:-true}

cat <<EOF

Server settings
=================
Name: ${NAME}
Description: ${DESCRIPTION}
Savegame: ${SAVEGAME}

Server Password: ${GAME_PASSWORD}
RCON Password: ${RCON_PASSWORD}
User Token: ${USER_TOKEN}

Lan Visibility: ${LAN_VISIBILITY}
Public Visibility: ${PUBLIC_VISIBILITY}

Max Players: ${MAX_PLAYERS}
Verify User Identity: ${VERIFY_IDENTITY}
Auto Pause: ${AUTO_PAUSE}

EOF


cat << EOF > /opt/factorio/server-settings.json
{
  "name": "${NAME}",
  "description": "${DESCRIPTION}",
  "tags": ["game", "tags"],

  "max_players": "${MAX_PLAYERS}",

  "visibility":
  {
    "public": ${PUBLIC_VISIBILITY},
    "lan": ${LAN_VISIBILITY}
  },

  "username": "",
  "password": "",
  "token": "${USER_TOKEN}",

  "game_password": "${GAME_PASSWORD}",

  "verify_user_identity": ${VERIFY_IDENTITY},

  "max_upload_in_kilobytes_per_second": 0,
  "minimum_latency_in_ticks": 0,
  "ignore_player_limit_for_returning_players": false,
  "allow_commands": "admins-only",
  "autosave_interval": 10,
  "autosave_slots": 5,
  "afk_autokick_interval": 0,
  "auto_pause": ${AUTO_PAUSE},
  "only_admins_can_pause_the_game": true,
  "autosave_only_on_server": true,
  "admins": []
}
EOF

if [ ! -e /opt/factorio/map-gen-settings.json ]
then
  echo "{}" > /opt/factorio/map-gen-settings.json
fi

if [ ! -e ${SAVEGAME} ]
then
  ${FACTORIO} --create ${SAVEGAME} --map-gen-settings /opt/factorio/map-gen-settings.json
fi

${FACTORIO} --start-server ${SAVEGAME} --server-settings /opt/factorio/server-settings.json --rcon-port 27015 --rcon-password ${RCON_PASSWORD}

#!/usr/bin/env bash

mkdir -p ~/.config/bloodhound
echo '{"databaseInfo": {"url": "bolt://neo4j:7687", "user": "neo4j", "password": "bloodhound"}}' > ~/.config/bloodhound/config.json

src=/BloodHound/Ingestors
if [ ! -d $src ]; then
    src=/BloodHound/Collectors
fi

cp $src/{SharpHound.exe,SharpHound.ps1} /tmp/shared

chown -R 1000:1000 /tmp/shared

/BloodHound/BloodHound-linux-x64/BloodHound --no-sandbox

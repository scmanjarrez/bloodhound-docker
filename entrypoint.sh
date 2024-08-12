#!/usr/bin/env bash

mkdir -p ~/.config/bloodhound
echo '{"databaseInfo": {"url": "bolt://neo4j:7687", "user": "neo4j", "password": "bloodhound"}}' > ~/.config/bloodhound/config.json

cp /Ingestors/{SharpHound.exe,SharpHound.ps1} /tmp/shared 2>/dev/null
chown -R 1000:1000 /tmp/shared 2>/dev/null

/BloodHound/BloodHound --no-sandbox

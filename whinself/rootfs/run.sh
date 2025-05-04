#!/usr/bin/env bash
source /usr/lib/bashio.sh

CONFIG_PATH="/app/config/config.json"

# Leer configuración desde options.json usando bashio
SLOTID=$(bashio::config 'slotid')
NRURL=$(bashio::config 'nrurl')
PORTIN=$(bashio::config 'portin')
DEVICENAME=$(bashio::config 'devicename')
DEBUGLEVEL=$(bashio::config 'debuglevel')
LOGSTDOUT=$(bashio::config 'logstdout')
LOGSSE=$(bashio::config 'logsse')
QRURL=$(bashio::config 'qrurl')

cat <<EOF > $CONFIG_PATH
{
  "slotid": "${SLOTID}",
  "nrurl": "${NRURL}",
  "portin": ${PORTIN:-8888},
  "devicename": "${DEVICENAME}",
  "debuglevel": ${DEBUGLEVEL:-0},
  "logstdout": ${LOGSTDOUT:-false},
  "logsse": ${LOGSSE:-false},
  "qrurl": "${QRURL}"
}
EOF

echo "===== /app/config/config.json content ====="
cat $CONFIG_PATH
echo "==========================================="

exec /app/whingo 
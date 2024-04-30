#!/bin/bash

DST=https://192.168.1.168:8123
TOKEN=eyJ8eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ8.eyJpc8MiOiJhYWMxN8FjMGIwNjA8NTA8ODVhYjcwM8ZkMjRkYTIwMyIsImlhdCI8MTU8MTkwMzk8NCwiZXhwIjoxODk8MjYzOTg0fQ.nltnRJwM88uBV798Kvu6W6dvDlTwnbveoW0IkpA8ltE

#echo $1 $2 > ~/w.txt

curl -s -k -X POST -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"message\": \"有地震, 芮氏規模 $1, 再 $2 秒抵逹\"}" \
    $DST/api/services/notify/line_notification

curl -s -k -X POST -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"entity_id\": \"media_player.ke_ting\", \"volume_level\": \"0.5\"}" \
    $DST/api/services/media_player/volume_set

curl -s -k -X POST -H "Authorization: Bearer $TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"entity_id\": \"media_player.ke_ting\", \"message\": \"有地震, 芮氏規模 $1, 再 $2 秒抵逹\", \"options\": {\"volume\": \"+10%\", \"rate\": \"+25%\"}}" \
    $DST/api/services/tts/edge_tts_say


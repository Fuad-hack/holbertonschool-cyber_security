#!/bin/bash
# Secure password hash (SHA-512 + random salt) using OpenSSL

# Təsadüfi 16 simvolluq salt yaradılır
salt=$(openssl rand -hex 8)

# Parol və salt birləşdirilir, sonra SHA-512 ilə heşlənir
echo -n "$1$salt" | openssl dgst -sha512 > 3_hash.txt

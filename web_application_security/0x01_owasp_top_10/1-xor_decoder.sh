#!/bin/bash
python3 -c 'import sys,base64; s=(sys.argv[1][6:] if sys.argv[1].startswith("{xor}") else sys.argv[1]); s+="="*((4-len(s)%4)%4); r=base64.b64decode(s); sys.stdout.buffer.write(bytes(b^0x42 for b in r))' "$1"

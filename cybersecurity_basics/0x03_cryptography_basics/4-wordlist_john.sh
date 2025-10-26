#!/bin/bash

# usage check
[ $# -ne 1 ] && { echo "Usage: $0 hash_file"; exit 1; }
hashfile="$1"
[ ! -f "$hashfile" ] && { echo "Error: file '$hashfile' not found"; exit 1; }

# locate rockyou wordlist (try common paths)
wordlist=""
tmp=""
if [ -f /usr/share/wordlists/rockyou.txt ]; then
  wordlist="/usr/share/wordlists/rockyou.txt"
elif [ -f /usr/share/wordlists/rockyou.txt.gz ]; then
  tmp=$(mktemp /tmp/rockyou.XXXXXX)
  gzip -dc /usr/share/wordlists/rockyou.txt.gz > "$tmp" || { rm -f "$tmp"; echo "Failed to decompress rockyou.gz"; exit 1; }
  wordlist="$tmp"
elif [ -f /usr/dict/rockyou.txt ]; then
  wordlist="/usr/dict/rockyou.txt"
else
  echo "rockyou wordlist not found in standard locations." >&2
  echo "Install rockyou or set ROCKYOU env var pointing to the wordlist." >&2
  exit 1
fi

# run john in wordlist mode (let john auto-detect format)
john --wordlist="$wordlist" "$hashfile"

# extract cracked passwords and write them to 4-password.txt (one per line)
# john --show output includes lines like 'hash:password' or 'user:password'
john --show "$hashfile" | awk -F: 'NF>=2 {print $2}' > 4-password.txt

# cleanup temporary decompressed file if any
[ -n "$tmp" ] && rm -f "$tmp"

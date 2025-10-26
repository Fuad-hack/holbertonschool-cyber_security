#!/bin/bash

sha1sum | awk '{print $1}' > 0_hash.txt

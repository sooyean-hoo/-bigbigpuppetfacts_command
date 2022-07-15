#!/bin/bash

# For Script should take data from stdin, process it then output it via stdout.

# For decompression/decoding/deprocessing
if [  "$__shellout2mode" = 'decompression'  ] ; then
	# Commands we use do deprocessing, we use 'tee' for simplicity. you can also use 'xz -d', 'base64 -d'  here
	tee
else
# For compression/encoding/processsing
	# Commands we use do processing, we use 'tee' for simplicity. you can also use 'xz', 'base64'  here
	tee
fi;

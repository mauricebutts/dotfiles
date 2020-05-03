#!/bin/sh
SEARCHSTRING=$1
grep --color -rn $SEARCHSTRING .

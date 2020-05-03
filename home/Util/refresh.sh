#!/bin/bash

# Clean up your inevitable big chrome mess
echo "CLEANING TIME!"
killall -9 "Google Chrome"

# Open Google Online Aps
open -na 'Google Chrome' --args --new-window "https://mail.google.com/mail/u/0/#inbox"
open -na 'Google Chrome' --args "https://calendar.google.com/calendar/r"

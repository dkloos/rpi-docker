#!/bin/bash
set -e

if [ ! -d "$SMADATA/logs" ]; then
	mkdir $SMADATA/logs
fi

# Startup cron daemon
exec $SBFSPOTDIR/SBFspotUploadDaemon

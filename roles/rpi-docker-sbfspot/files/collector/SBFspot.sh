#!/bin/bash
set -e

if [ ! -d "$SMADATA/logs" ]; then
	mkdir $SMADATA/logs
fi

if [ ! -f "$SMADATA/SBFspot.db" ]; then
	echo -n "Creating new SBFspot DB... "
	cd $SMADATA
	sqlite3 SBFspot.db < $SBFSPOTDIR/CreateSQLiteDB.sql
	echo "done!"
fi

exec /opt/sbfspot/SBFspot "$@"

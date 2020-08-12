# ---------

# MAC

# Install
brew install postgresql

# Manage
brew services start postgresql
brew services restart postgresql
brew services stop postgresql

# List all brew services
brew services list

# List all databases on your device
psql --list

# ---------

# DEBIAN

# TODO

# ---------

# TROUBLE SHOOTING

# PG::ConnectionBad`
# EADDRINUSE

# Check if Postgres is running.
# Port 3000 is already taken by another process. This is most likely a rogue Puma
# process that wasn't stopped properly. Find the process ID (pid) by running:

sudo lsof -iTCP -sTCP:LISTEN -P

# Then kill the one listening to port 3000

kill -9 [pid]

# ---------

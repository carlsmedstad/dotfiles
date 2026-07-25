install:
	./lninstall

check:
	luacheck .
	stylua --allow-hidden --check .

fix:
	stylua --allow-hidden .

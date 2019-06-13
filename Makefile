#
# Makefile
# Shlomi Fish, 2019-06-13 14:26
#

all: tocatta.wav parts/f000001.wav

tocatta.wav: toccata.mod
	xmp -o$@ $<

parts/f000001.wav: tocatta.wav
	perl -lE 'for my $$n (0 .. 3000) { my $$out = sprintf("parts/f%06d.wav", $$n); say $$out; my @cmd =("sox", "$<", $$out, "trim", $$n / 10, "=".(($$n+1)/10)); say join" ",@cmd; -e $$out or system(@cmd); }'

test: all
	cd parts && mpv --volume 10 --shuffle *.wav

# vim:ft=make
#

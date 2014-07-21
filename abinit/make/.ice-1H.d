./ice-1H.log: ./inputs/ice-1H.inp
./ice-1H.log: ./inputs/1h.pspnc
./ice-1H.log: ./inputs/8o.pspnc
./outputs/ice-1H.out: ./ice-1H.log
	@cd .; test -f ./outputs/ice-1H.out || sh -xc './ice-1H.com > ice-1H.log 2>&1'
	@cd .; test -f ./outputs/ice-1H.out && touch ./outputs/ice-1H.out
CLEAN_FILES += ./outputs/ice-1H.out
CLEAN_FILE_TARGETS += cleanfileice-1H
cleanfileice-1H:
	rm -f ./outputs/ice-1H.out
CLEAN_TARGETS +=cleanice-1H
cleanice-1H: cleanfileice-1H
	rm -f ./ice-1H.log

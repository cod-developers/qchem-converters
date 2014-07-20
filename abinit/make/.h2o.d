./h2o.log: ./inputs/h2o.inp
./h2o.log: ./inputs/1h.pspnc
./h2o.log: ./inputs/8o.pspnc
./outputs/h2o.out: ./h2o.log
	@cd .; test -f ./outputs/h2o.out || sh -xc './h2o.com > h2o.log 2>&1'
	@cd .; test -f ./outputs/h2o.out && touch ./outputs/h2o.out
CLEAN_FILES += ./outputs/h2o.out
CLEAN_FILE_TARGETS += cleanfileh2o
cleanfileh2o:
	rm -f ./outputs/h2o.out
CLEAN_TARGETS +=cleanh2o
cleanh2o: cleanfileh2o
	rm -f ./h2o.log

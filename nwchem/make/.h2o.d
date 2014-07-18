./outputs/h2o.nw: ./h2o.log
	@cd .; test -f ./outputs/h2o.nw || sh -xc './h2o.com > h2o.log 2>&1'
	@cd .; test -f ./outputs/h2o.nw && touch ./outputs/h2o.nw
./outputs/h2o.out: ./h2o.log
	@cd .; test -f ./outputs/h2o.out || sh -xc './h2o.com > h2o.log 2>&1'
	@cd .; test -f ./outputs/h2o.out && touch ./outputs/h2o.out
CLEAN_FILES += ./outputs/h2o.nw ./outputs/h2o.out
CLEAN_FILE_TARGETS += cleanfileh2o
cleanfileh2o:
	rm -f ./outputs/h2o.nw
	rm -f ./outputs/h2o.out
CLEAN_TARGETS +=cleanh2o
cleanh2o: cleanfileh2o
	rm -f ./h2o.log

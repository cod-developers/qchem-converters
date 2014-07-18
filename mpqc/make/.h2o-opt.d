./outputs/h2o-opt.inp: ./h2o-opt.log
	@cd .; test -f ./outputs/h2o-opt.inp || sh -xc './h2o-opt.com > h2o-opt.log 2>&1'
	@cd .; test -f ./outputs/h2o-opt.inp && touch ./outputs/h2o-opt.inp
./outputs/h2o-opt.out: ./h2o-opt.log
	@cd .; test -f ./outputs/h2o-opt.out || sh -xc './h2o-opt.com > h2o-opt.log 2>&1'
	@cd .; test -f ./outputs/h2o-opt.out && touch ./outputs/h2o-opt.out
CLEAN_FILES += ./outputs/h2o-opt.inp ./outputs/h2o-opt.out
CLEAN_FILE_TARGETS += cleanfileh2o-opt
cleanfileh2o-opt:
	rm -f ./outputs/h2o-opt.inp
	rm -f ./outputs/h2o-opt.out
CLEAN_TARGETS +=cleanh2o-opt
cleanh2o-opt: cleanfileh2o-opt
	rm -f ./h2o-opt.log

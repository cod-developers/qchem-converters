./outputs/t11.inp: ./t11.log
	@cd .; test -f ./outputs/t11.inp || sh -xc './t11.com > t11.log 2>&1'
	@cd .; test -f ./outputs/t11.inp && touch ./outputs/t11.inp
./outputs/t11.out: ./t11.log
	@cd .; test -f ./outputs/t11.out || sh -xc './t11.com > t11.log 2>&1'
	@cd .; test -f ./outputs/t11.out && touch ./outputs/t11.out
CLEAN_FILES += ./outputs/t11.inp ./outputs/t11.out
CLEAN_FILE_TARGETS += cleanfilet11
cleanfilet11:
	rm -f ./outputs/t11.inp
	rm -f ./outputs/t11.out
CLEAN_TARGETS +=cleant11
cleant11: cleanfilet11
	rm -f ./t11.log

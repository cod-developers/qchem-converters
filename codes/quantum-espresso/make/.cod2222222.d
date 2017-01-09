./outputs/cod2222222.in: ./cod2222222.log
	@cd .; test -f ./outputs/cod2222222.in || sh -xc './cod2222222.com > cod2222222.log 2>&1'
	@cd .; test -f ./outputs/cod2222222.in && touch ./outputs/cod2222222.in
./outputs/cod2222222.out: ./cod2222222.log
	@cd .; test -f ./outputs/cod2222222.out || sh -xc './cod2222222.com > cod2222222.log 2>&1'
	@cd .; test -f ./outputs/cod2222222.out && touch ./outputs/cod2222222.out
CLEAN_FILES += ./outputs/cod2222222.in ./outputs/cod2222222.out
CLEAN_FILE_TARGETS += cleanfilecod2222222
cleanfilecod2222222:
	rm -f ./outputs/cod2222222.in
	rm -f ./outputs/cod2222222.out
CLEAN_TARGETS +=cleancod2222222
cleancod2222222: cleanfilecod2222222
	rm -f ./cod2222222.log

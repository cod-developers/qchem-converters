./outputs/co.in.xml: ./co.log
	@cd .; test -f ./outputs/co.in.xml || sh -xc './co.com > co.log 2>&1'
	@cd .; test -f ./outputs/co.in.xml && touch ./outputs/co.in.xml
./outputs/co.out: ./co.log
	@cd .; test -f ./outputs/co.out || sh -xc './co.com > co.log 2>&1'
	@cd .; test -f ./outputs/co.out && touch ./outputs/co.out
CLEAN_FILES += ./outputs/co.in.xml ./outputs/co.out
CLEAN_FILE_TARGETS += cleanfileco
cleanfileco:
	rm -f ./outputs/co.in.xml
	rm -f ./outputs/co.out
CLEAN_TARGETS +=cleanco
cleanco: cleanfileco
	rm -f ./co.log

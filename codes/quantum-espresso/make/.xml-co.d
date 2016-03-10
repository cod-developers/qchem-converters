./outputs/xml-co.in.xml: ./xml-co.log
	@cd .; test -f ./outputs/xml-co.in.xml || sh -xc './xml-co.com > xml-co.log 2>&1'
	@cd .; test -f ./outputs/xml-co.in.xml && touch ./outputs/xml-co.in.xml
./outputs/xml-co.out: ./xml-co.log
	@cd .; test -f ./outputs/xml-co.out || sh -xc './xml-co.com > xml-co.log 2>&1'
	@cd .; test -f ./outputs/xml-co.out && touch ./outputs/xml-co.out
CLEAN_FILES += ./outputs/xml-co.in.xml ./outputs/xml-co.out
CLEAN_FILE_TARGETS += cleanfilexml-co
cleanfilexml-co:
	rm -f ./outputs/xml-co.in.xml
	rm -f ./outputs/xml-co.out
CLEAN_TARGETS +=cleanxml-co
cleanxml-co: cleanfilexml-co
	rm -f ./xml-co.log

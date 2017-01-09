./outputs/cod2222222-mpi.in: ./cod2222222-mpi.log
	@cd .; test -f ./outputs/cod2222222-mpi.in || sh -xc './cod2222222-mpi.com > cod2222222-mpi.log 2>&1'
	@cd .; test -f ./outputs/cod2222222-mpi.in && touch ./outputs/cod2222222-mpi.in
./outputs/cod2222222-mpi.out: ./cod2222222-mpi.log
	@cd .; test -f ./outputs/cod2222222-mpi.out || sh -xc './cod2222222-mpi.com > cod2222222-mpi.log 2>&1'
	@cd .; test -f ./outputs/cod2222222-mpi.out && touch ./outputs/cod2222222-mpi.out
CLEAN_FILES += ./outputs/cod2222222-mpi.in ./outputs/cod2222222-mpi.out
CLEAN_FILE_TARGETS += cleanfilecod2222222-mpi
cleanfilecod2222222-mpi:
	rm -f ./outputs/cod2222222-mpi.in
	rm -f ./outputs/cod2222222-mpi.out
CLEAN_TARGETS +=cleancod2222222-mpi
cleancod2222222-mpi: cleanfilecod2222222-mpi
	rm -f ./cod2222222-mpi.log

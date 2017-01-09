./outputs/cod2222222-mpi-dplace.in: ./cod2222222-mpi-dplace.log
	@cd .; test -f ./outputs/cod2222222-mpi-dplace.in || sh -xc './cod2222222-mpi-dplace.com > cod2222222-mpi-dplace.log 2>&1'
	@cd .; test -f ./outputs/cod2222222-mpi-dplace.in && touch ./outputs/cod2222222-mpi-dplace.in
./outputs/cod2222222-mpi-dplace.out: ./cod2222222-mpi-dplace.log
	@cd .; test -f ./outputs/cod2222222-mpi-dplace.out || sh -xc './cod2222222-mpi-dplace.com > cod2222222-mpi-dplace.log 2>&1'
	@cd .; test -f ./outputs/cod2222222-mpi-dplace.out && touch ./outputs/cod2222222-mpi-dplace.out
CLEAN_FILES += ./outputs/cod2222222-mpi-dplace.in ./outputs/cod2222222-mpi-dplace.out
CLEAN_FILE_TARGETS += cleanfilecod2222222-mpi-dplace
cleanfilecod2222222-mpi-dplace:
	rm -f ./outputs/cod2222222-mpi-dplace.in
	rm -f ./outputs/cod2222222-mpi-dplace.out
CLEAN_TARGETS +=cleancod2222222-mpi-dplace
cleancod2222222-mpi-dplace: cleanfilecod2222222-mpi-dplace
	rm -f ./cod2222222-mpi-dplace.log

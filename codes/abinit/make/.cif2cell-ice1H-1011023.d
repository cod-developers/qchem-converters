./cif2cell-ice1H-1011023.log: inputs/1011023.cif
./outputs/cif2cell-ice1H-1011023.abinit.inp: ./cif2cell-ice1H-1011023.log
	@cd .; test -f ./outputs/cif2cell-ice1H-1011023.abinit.inp || sh -xc './cif2cell-ice1H-1011023.com > cif2cell-ice1H-1011023.log 2>&1'
	@cd .; test -f ./outputs/cif2cell-ice1H-1011023.abinit.inp && touch ./outputs/cif2cell-ice1H-1011023.abinit.inp
CLEAN_FILES += ./outputs/cif2cell-ice1H-1011023.abinit.inp
CLEAN_FILE_TARGETS += cleanfilecif2cell-ice1H-1011023
cleanfilecif2cell-ice1H-1011023:
	rm -f ./outputs/cif2cell-ice1H-1011023.abinit.inp
CLEAN_TARGETS +=cleancif2cell-ice1H-1011023
cleancif2cell-ice1H-1011023: cleanfilecif2cell-ice1H-1011023
	rm -f ./cif2cell-ice1H-1011023.log

./cif2cell-1011063.log: inputs/1011063.cif
./outputs/cif2cell-1011063.abinit.inp: ./cif2cell-1011063.log
	@cd .; test -f ./outputs/cif2cell-1011063.abinit.inp || sh -xc './cif2cell-1011063.com > cif2cell-1011063.log 2>&1'
	@cd .; test -f ./outputs/cif2cell-1011063.abinit.inp && touch ./outputs/cif2cell-1011063.abinit.inp
CLEAN_FILES += ./outputs/cif2cell-1011063.abinit.inp
CLEAN_FILE_TARGETS += cleanfilecif2cell-1011063
cleanfilecif2cell-1011063:
	rm -f ./outputs/cif2cell-1011063.abinit.inp
CLEAN_TARGETS +=cleancif2cell-1011063
cleancif2cell-1011063: cleanfilecif2cell-1011063
	rm -f ./cif2cell-1011063.log

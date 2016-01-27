#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_INP=./outputs/${BASENAME}.inp
OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

TMP_FILES="${TMP_DIR}/${BASENAME}.files"

set -x

cat > ${OUTPUT_INP} <<EOF
# H2 molecule in a big box
#
# In this input file, the location of the information on this or that line
# is not important : a keyword is located by the parser, and the related
# information should follow. 
# The "#" symbol indicates the beginning of a comment : the remaining
# of the line will be skipped.

#Definition of the unit cell
acell 10 10 10    # The keyword "acell" refers to the
                  # lengths of the primitive vectors (in Bohr)

#Definition of the atom types
ntypat 1          # There is only one type of atom
znucl 1           # The keyword "znucl" refers to the atomic number of the 
                  # possible type(s) of atom. The pseudopotential(s) 
                  # mentioned in the "files" file must correspond
                  # to the type(s) of atom. Here, the only type is Hydrogen.
                         

#Definition of the atoms
natom 2           # There are two atoms
typat 1 1         # They both are of type 1, that is, Hydrogen
xcart             # This keyword indicates that the location of the atoms
                  # will follow, one triplet of number for each atom
  -0.7 0.0 0.0    # Triplet giving the cartesian coordinates of atom 1, in Bohr
   0.7 0.0 0.0    # Triplet giving the cartesian coordinates of atom 2, in Bohr

#Definition of the planewave basis set
ecut 10.0         # Maximal plane-wave kinetic energy cut-off, in Hartree

#Definition of the k-point grid
nkpt 1            # Only one k point is needed for isolated system,
                  # taken by default to be 0.0 0.0 0.0

#Definition of the SCF procedure
nstep 10          # Maximal number of SCF cycles
toldfe 1.0d-6     # Will stop when, twice in a row, the difference 
                  # between two consecutive evaluations of total energy 
                  # differ by less than toldfe (in Hartree) 
diemac 2.0        # Although this is not mandatory, it is worth to
                  # precondition the SCF cycle. The model dielectric
                  # function used as the standard preconditioner
                  # is described in the "dielng" input variable section.
                  # Here, we follow the prescriptions for molecules 
                  # in a big box
EOF

cat > ${TMP_FILES} <<EOF
$(basename ${OUTPUT_INP})
$(basename ${OUTPUT_DAT})
${BASENAME}i
${BASENAME}o
${BASENAME}
/usr/share/doc/abinit-doc/tests/Psps_for_tests/01h.pspgth
EOF

cp ${OUTPUT_INP} ${TMP_DIR}

(
    cd ${TMP_DIR}
    abinis < $(basename ${TMP_FILES})
)

## tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

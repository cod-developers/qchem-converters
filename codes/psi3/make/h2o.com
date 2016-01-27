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

PSEUDO_DIR=/usr/share/espresso/pseudo

set -x

# Cat'ting contents of the /usr/share/doc/nwchem/examples/input.nw:

cat > ${OUTPUT_INP} <<EOF
% file input.dat
default: (
    label = "water STO HF energy point"
    memory = (8.0 Mbytes)
    wfn = scf
    reference = rhf

    files: (
        default: (
            name = "${BASENAME}"
            nvolume = 1
            volume1 = "./tmp/"
        )
        file30: (
            nvolume = 1
            volume1 = "./"
        )
    )
)

psi: (
    %% check = true
)

input: (
    % note that all atoms are specified now,
    % not only the symmetry unique portion.
    basis = sto-3g
    units = angstrom
    zmat = (
        (o)
        (h 1 0.9600)
        (h 1 0.9600 2 104.5)
    )
)
% end file input.dat
EOF

set -x

cp ${OUTPUT_INP} ${TMP_DIR}/input.dat

(
    cd ${TMP_DIR}
    mkdir tmp
    psi3
)

tree ${TMP_DIR}

mv ${TMP_DIR}/output.dat ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

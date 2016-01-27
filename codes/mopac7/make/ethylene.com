#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_INP=./outputs/${BASENAME}.inp
OUTPUT_DAT=./outputs/${BASENAME}.out
OUTPUT_ARC=./outputs/${BASENAME}.arc

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

PSEUDO_DIR=/usr/share/espresso/pseudo

set -x

# Cat'ting contents of the /usr/share/doc/nwchem/examples/input.nw:

cat > ${OUTPUT_INP} <<EOF
 UHF PULAY MINDO3 VECTORS DENSITY LOCAL T=300
  EXAMPLE OF DATA FOR MOPAC
    MINDO/3 UHF CLOSED-SHELL D2D ETHYLENE
C
C 1.400118 1
H 1.098326 1 123.572063 1
H 1.098326 1 123.572063 1 180.000000 0 2 1 3
H 1.098326 1 123.572063 1  90.000000 0 1 2 3
H 1.098326 1 123.572063 1 270.000000 0 1 2 3

EOF

set -x

cp ${OUTPUT_INP} ${TMP_DIR}/${BASENAME}.dat

(
    cd ${TMP_DIR}
    run_mopac7 ${BASENAME}
)

cat ${TMP_DIR}/${BASENAME}.log

tree ${TMP_DIR}

mv ${TMP_DIR}/${BASENAME}.OUT ${OUTPUT_DAT}
mv ${TMP_DIR}/${BASENAME}.arc ${OUTPUT_ARC}

rm -rf "${TMP_DIR}"

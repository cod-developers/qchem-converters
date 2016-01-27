#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_INP=./outputs/${BASENAME}.inp
OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

## test -z "${TMP_DIR}" && TMP_DIR="."
## TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
## mkdir "${TMP_DIR}"

set -x

cat > ${OUTPUT_INP} <<EOF
molecule:
    O    0.172   0.000   0.000
    H    0.745   0.000   0.754
    H    0.745   0.000  -0.754

optimize: yes
checkpoint: no

method: MP2

basis: cc-pVDZ
EOF

mpqc ${OUTPUT_INP} | tee ${OUTPUT_DAT}

## rm -rf "${TMP_DIR}"

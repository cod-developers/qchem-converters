#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

INPUT_CIF=inputs/1011063.cif

BASENAME="`basename $0 .com`"

OUTPUT_DAT=./outputs/${BASENAME}.abinit.inp

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

set -x

cif2cell \
    -p abinit \
    ${INPUT_CIF} \
    -o ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

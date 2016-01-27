#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_INP=./outputs/${BASENAME}.nw
OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

PSEUDO_DIR=/usr/share/espresso/pseudo

set -x

# Cat'ting contents of the /usr/share/doc/nwchem/examples/input.nw:

cat > ${OUTPUT_INP} <<EOF
echo
title "VS98/6-31+G* h2o gradient "

start h2o

geometry
   O                    -0.091502   -0.000000   -0.071590
   H                    -0.108430   -0.000000    0.892753
   H                     0.840442    0.000000   -0.320034
end

basis
* library 6-31+G*
end

dft
xc vs98
mult 1
grid fine
end

task dft gradient
EOF

set -x

cp ${OUTPUT_INP} ${TMP_DIR}

(
    cd ${TMP_DIR}
    nwchem $(basename ${OUTPUT_INP}) | tee $(basename ${OUTPUT_DAT})
)

tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

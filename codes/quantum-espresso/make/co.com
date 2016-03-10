#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_CTRL=./outputs/${BASENAME}.in
OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

PSEUDO_DIR=/usr/share/espresso/pseudo

set -x

cat > ${OUTPUT_CTRL} <<EOF
&CONTROL
  calculation  = "relax",
  prefix       = "CO",
  pseudo_dir   = "$PSEUDO_DIR",
  outdir       = "$TMP_DIR",
/
&SYSTEM
  ibrav     = 0,
  nat       = 2,
  ntyp      = 2,
  ecutwfc   = 24.D0,
  ecutrho   = 144.D0,
/
&ELECTRONS
  conv_thr    = 1.D-7,
  mixing_beta = 0.7D0,
/
&IONS
/
CELL_PARAMETERS cubic
12.0  0.0  0.0
 0.0 12.0  0.0
 0.0  0.0 12.0
ATOMIC_SPECIES
O  1.00  O.pz-rrkjus.UPF
C  1.00  C.pz-rrkjus.UPF
ATOMIC_POSITIONS {bohr}
C  2.256  0.0  0.0
O  0.000  0.0  0.0  0 0 0
K_POINTS {Gamma}
EOF

set -x

cp ${OUTPUT_CTRL} ${TMP_DIR}

(
    cd ${TMP_DIR}
    pw.x < $(basename ${OUTPUT_CTRL}) | tee $(basename ${OUTPUT_DAT})
)

tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

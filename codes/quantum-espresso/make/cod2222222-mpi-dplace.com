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

PSEUDO_DIR=../../../../pseudopotentials/SSSP_acc_PBE

set -x

cat > ${OUTPUT_CTRL} <<EOF
&CONTROL
  calculation  = "relax",
  prefix       = "CO",
  pseudo_dir   = "$PSEUDO_DIR",
  outdir       = "$TMP_DIR",
  nstep        = 1,
/
&SYSTEM
  ibrav     = 8,
  A         = 8.5379,
  B         = 14.696,
  C         = 15.467,
  cosAB     = 0,
  cosAC     = 0,
  cosBC     = 0,
  nat       = 25,
  ntyp      = 6,
  ecutwfc   = 24.D0,
  ecutrho   = 144.D0,
  space_group = 61,
/
&ELECTRONS
  conv_thr    = 1.D-7,
  mixing_beta = 0.7D0,
/
&IONS
/
ATOMIC_SPECIES
B  1.00  B.pbe-n-kjpaw_psl.0.1.UPF
C  1.00  C_pbe_v1.2.uspp.F.UPF
F  1.00  f_pbe_v1.4.uspp.F.UPF
H  1.00  H.pbe-rrkjus_psl.0.1.UPF
N  1.00  N.pbe.theos.UPF
O  1.00  O.pbe-n-kjpaw_psl.0.1.UPF
ATOMIC_POSITIONS crystal_sg
F 0.11305 0.18492 1.00731
F 0.99781 0.14892 0.87999
N 0.36490 0.15195 0.86608
N 0.20684 0.04677 0.93336
N 0.03539 -0.04321 1.00022
B 0.0693 0.11566 0.95247
C 0.5141 0.26721 0.79215
H 0.4310 0.2784 0.7517
H 0.6132 0.2741 0.7635
H 0.5071 0.3099 0.8390
C 0.50004 0.17214 0.82689
C 0.6203 0.10902 0.81609
H 0.7136 0.1272 0.7903
C 0.60339 0.02021 0.84293
C 0.7318 -0.04743 0.82761
H 0.7073 -0.0835 0.7776
H 0.7418 -0.0863 0.8772
H 0.8287 -0.0158 0.8182
C 0.46063 -0.00410 0.88339
C 0.4213 -0.09362 0.91393
H 0.4938 -0.1404 0.9078
C 0.2814 -0.11140 0.95139
H 0.2559 -0.1699 0.9696
C 0.17464 -0.03837 0.96207
C 0.34843 0.06558 0.89359
K_POINTS {Gamma}
EOF

#CELL_PARAMETERS angstrom
#8.5379 0.0    0.0
# 0.0   14.696 0.0
# 0.0   0.0    15.467

set -x

cp ${OUTPUT_CTRL} ${TMP_DIR}

(
    cd ${TMP_DIR}
    mpirun -np 64 dplace -c 0-63 pw.x < $(basename ${OUTPUT_CTRL}) \
        | tee $(basename ${OUTPUT_DAT})
)

tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

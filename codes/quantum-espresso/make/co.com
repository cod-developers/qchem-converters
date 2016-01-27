#!/bin/sh

TMP_DIR="${TMPDIR}"

setvar() { eval $1="'$3'"; }

set -ue

#BEGIN DEPEND------------------------------------------------------------------

BASENAME="`basename $0 .com`"

OUTPUT_XML=./outputs/${BASENAME}.in.xml
OUTPUT_DAT=./outputs/${BASENAME}.out

#END DEPEND--------------------------------------------------------------------

test -z "${TMP_DIR}" && TMP_DIR="."
TMP_DIR="${TMP_DIR}/tmp-${BASENAME}-$$"
mkdir "${TMP_DIR}"

PSEUDO_DIR=/usr/share/espresso/pseudo

set -x

cat > ${OUTPUT_XML} <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<input calculation="relax" prefix="CO">

  <cell type="matrix" sym="cubic" units="angstrom">
    <matrix>
      <real rank="2" n1="3" n2="3">				
        12.0  0.0  0.0
        0.0 12.0  0.0
        0.0  0.0 12.0
      </real>
    </matrix>
  </cell>

  <atomic_species ntyp="2">
    <specie name="O">
      <property name="mass">
        <real>1.00</real>
      </property>
      <property name="pseudofile">
        <string>O.pz-rrkjus.UPF</string>
      </property>
    </specie>
    <specie name="C">
      <property name="mass">
        <real>1.00</real>
      </property>
      <property name="pseudofile">
        <string>C.pz-rrkjus.UPF</string>
      </property>
    </specie>
  </atomic_species>

  <atomic_list units="bohr" nat="2" >
    <atom name="C">
      <position>
        <real rank="1" n1="3">
          2.256  0.0  0.0
        </real>
      </position>
    </atom>	
    <atom name="O">
      <position ifx="0" ify="0" ifz="0">
        <real rank="1" n1="3">
          0.000  0.0  0.0
        </real>
      </position>
    </atom>		
  </atomic_list>		
  
  <field name="InputOutput">

    <parameter name="pseudo_dir">
      <string>$PSEUDO_DIR/</string>
    </parameter>
    
    <parameter name="outdir">
      <string>./tmp/</string>
    </parameter>
    
  </field>
  
  <field name="Numerics">

    <parameter name="ecutwfc">
      <real>24.D0</real>
    </parameter>
    
    <parameter name="ecutrho">
      <real>144.D0</real>
    </parameter>
    
    <parameter name="conv_thr">
      <real>1.D-7</real>
    </parameter>
    
    <parameter name="mixing_beta">
      <real>0.7D0</real>
    </parameter>
    
  </field>
  
  <k_points type="gamma">	
  </k_points>
  
</input>
EOF

set -x

cp ${OUTPUT_XML} ${TMP_DIR}

(
    cd ${TMP_DIR}
    pw.x < $(basename ${OUTPUT_XML}) | tee $(basename ${OUTPUT_DAT})
)

tree ${TMP_DIR}

mv ${TMP_DIR}/$(basename ${OUTPUT_DAT}) ${OUTPUT_DAT}

rm -rf "${TMP_DIR}"

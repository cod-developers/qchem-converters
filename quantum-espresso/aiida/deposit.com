#!/bin/bash

CONFIG=~/.cod_deposit.cfg

DEP_NAME="$(grep ^username ${CONFIG} | cut -d = -f 2)"
DEP_MAIL="$(grep ^email ${CONFIG} | cut -d = -f 2)"
DEP_URL=http://www.crystallography.net/tcod/cgi-bin/cif-deposit.pl

cut -d = -f 4 pw_vcrelax-cod.log \
    | uniq \
    | paste - pw_vcrelax-cod.lst \
    | while read i
      do
        PROC=$(echo $i | awk '{print $1}')
        CODID=$(echo $i | awk '{print $2}')
        verdi calculation show $PROC \
            | grep -q logshow || verdi calculation show ${PROC} \
            | grep output_structure \
            | cut -d ' ' -f 2 \
            | xargs -i verdi data structure deposit {} \
                --database tcod \
                --url "${DEP_URL}" \
                --username "${DEP_NAME}" \
                --password \
                --type personal \
                --user-email "${DEP_MAIL}" \
                --code cif_cod_deposit_local \
                --computer theospc11 \
                --gzip \
                --title "Relaxation of COD entry ${CODID} using Quantum ESPRESSO and SSSP"
      done

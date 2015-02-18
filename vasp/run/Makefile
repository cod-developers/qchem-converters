INP_DIR = inputs
OUT_DIR = outputs

PATH := bin:${PATH}
export PATH

INPUTS  = ${filter-out %.lst, ${wildcard ${INP_DIR}/*}}
OUTPUTS = ${INPUTS:${INP_DIR}/%=${OUT_DIR}/%.tar.gz}

DEPEND = ${INPUTS:${INP_DIR}/%=${INP_DIR}/.%.d}

all: ${OUTPUTS}

ifneq ("${DEPEND}","")
    include ${DEPEND}
endif

#------------------------------------------------------------------------------

${INP_DIR}/.%.d: ${INP_DIR}/%
	find $< -type f | xargs -i echo ${OUT_DIR}/$*.tar.gz: {} > $@

${OUT_DIR}/%.tar.gz:
	run_vasp ${INP_DIR}/$* > $@

#------------------------------------------------------------------------------

clean:
	rm -f ${DEPEND}

cleanAll: clean
	rm -f ${OUTPUTS}

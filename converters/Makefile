#---*- Makefile -*-------------------------------------------------------------
#$Author$
#$Revision$
#$Date$
#$URL$
#------------------------------------------------------------------------------

MAKECONF_FILES = ${filter-out %~, ${wildcard Makeconf*}}

ifneq ("${MAKECONF_FILES}","")
include ${MAKECONF_FILES}
endif

CWD := ${shell pwd}
TOP := ${dir ${CWD}}
PERL5LIB := ${CWD}/lib/perl5:${PERL5LIB}
PERL5LIB := ${TOP}/lib/perl5:${PERL5LIB}
export PERL5LIB

# Directory where the tested scripts reside:
SCRIPT_DIR = ./scripts

.PRECIOUS: %.pm

.PHONY: all tests clean distclean cleanAll

all: tests

#------------------------------------------------------------------------------

%.pm: %.yp
	yapp -o $@ $<

#------------------------------------------------------------------------------

MAKELOCAL_FILES = ${filter-out %~, ${wildcard Makelocal*}}

ifneq ("${MAKELOCAL_FILES}","")
include ${MAKELOCAL_FILES}
endif

#------------------------------------------------------------------------------
# Extensions of the test-case files:

INP = inp
OPT = opt
DIF = diff
SCR = sh
OUT = out

# Test case and smale putput files and directories:

TEST_DIR   = ./tests
OUTPUT_DIR = ./outputs

TEST_FILES  = ${wildcard ${TEST_DIR}/*.${INP}}
OPT_FILES   = ${wildcard ${TEST_DIR}/*.${OPT}}
SHELL_FILES = ${wildcard ${TEST_DIR}/*.${SCR}}

OUTP_FILES = \
$(sort \
    ${patsubst ${TEST_DIR}/%.${INP},${OUTPUT_DIR}/%.${OUT},${TEST_FILES}} \
    ${patsubst ${TEST_DIR}/%.${OPT},${OUTPUT_DIR}/%.${OUT},${OPT_FILES}} \
    ${patsubst ${TEST_DIR}/%.${SCR},${OUTPUT_DIR}/%.${OUT},${SHELL_FILES}} \
)

DIFF_FILES =  \
$(sort \
    ${patsubst ${TEST_DIR}/%.${INP},${OUTPUT_DIR}/%.${DIF},${TEST_FILES}} \
    ${patsubst ${TEST_DIR}/%.${OPT},${OUTPUT_DIR}/%.${DIF},${OPT_FILES}} \
    ${patsubst ${TEST_DIR}/%.${SCR},${OUTPUT_DIR}/%.${DIF},${SHELL_FILES}} \
)

#------------------------------------------------------------------------------
# Generate %.diff file dependencies from their respcetive scripts:

include .diff.depend

ALL_INPUTS = $(wildcard ${TEST_DIR}/*.*)

.diff.depend: ${ALL_INPUTS}
	@perl -le \
		'for(@ARGV){ print "${OUTPUT_DIR}/",$$1,"_",$$2,".diff: ${SCRIPT_DIR}/",$$1 if m|/(.*?)_(\d{2,4})\.\w{3}$$| }' \
	$^ | sort | uniq \
	> $@

#------------------------------------------------------------------------------

define filter_perl_messages
perl -pe 's/\$$Id(: [-\w]+ \d+ [-\d]+ [:\dZ]+ \w+\s+)?\$$/\$$Id: <script_name> <revision_nr> <date> <time> <author> \$$/' \
| perl -pe 's,at [-\.\/\w\d]+ line \d+\.,at <script_name> line <line_no>.,' \
| perl -pe 's/Use of uninitialized value [^\s]+ in/Use of uninitialized value in/g' \
| perl -pe 's/(Use of uninitialized value in pattern match \(m\/\/\) at )([a-zA-Z0-9\-\/]+)\/([a-zA-Z0-9\-\.]+) line \d+, <([^>])+> line \d+/$$1$$3 line <line_no>/g'
endef

define buffer_output
perl -0777 -lne 'print $$_;'
endef

#------------------------------------------------------------------------------

.PHONY: out outputs test tests alltests

outputs: ${OUTP_FILES}

test: ${DIFF_FILES}

tests alltests: test

out: outputs

# Rules to run script-specific tests

${OUTPUT_DIR}/%.diff: ${TEST_DIR}/%.${INP} ${TEST_DIR}/%.${OPT} ${YAPP_MODULES}
	-@printf "%-30s " "$*:" ; \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 2, $^}) \
	    $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| diff ${OUTPUT_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTPUT_DIR}/%.diff: ${TEST_DIR}/%.${INP} ${YAPP_MODULES}
	-@printf "%-30s " "$*:" ; \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| diff ${OUTPUT_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTPUT_DIR}/%.diff: ${TEST_DIR}/%.${OPT} ${YAPP_MODULES}
	-@printf "%-30s " "$*:" ; \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	     $(shell grep -v '^#' ${word 1, $^}) \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| diff ${OUTPUT_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTPUT_DIR}/%.diff: ${TEST_DIR}/%.${SCR} ${YAPP_MODULES}
	-@printf "%-30s " "$*:" ; \
	( $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| diff ${OUTPUT_DIR}/$*.out - > $@ ; \
	if [ $$? = 0 ]; then echo "OK"; else echo "FAILED:"; cat $@; fi

${OUTPUT_DIR}/%.out: ${TEST_DIR}/%.${INP} ${TEST_DIR}/%.${OPT} ${YAPP_MODULES}
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 2, $^}) \
	    $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| tee $@
	-@touch $@

${OUTPUT_DIR}/%.out: ${TEST_DIR}/%.${INP} ${YAPP_MODULES}
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| tee $@
	-@touch $@

${OUTPUT_DIR}/%.out: ${TEST_DIR}/%.${OPT} ${YAPP_MODULES}
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	( ${SCRIPT_DIR}/$(shell echo $* | sed -e 's/_[0-9]*$$//') \
	    $(shell grep -v '^#' ${word 1, $^}) \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} \
	| tee $@
	-@touch $@

${OUTPUT_DIR}/%.out: ${TEST_DIR}/%.${SCR} ${YAPP_MODULES}
	-@test -f $@ || echo "$@:"
	-@test -f $@ || \
	( $< \
	| ${buffer_output} ) 2>&1 \
	| ${filter_perl_messages} | tee $@
	-@touch $@

#------------------------------------------------------------------------------

.PHONY: listdiff

listdiff: # test
	@-( test -d ${OUTPUT_DIR} && \
	    ls -l ${OUTPUT_DIR}/*.diff | awk '{if( $$5 > 0 ) print}' ) || \
	    true
	@-( test -d ${SHELL_OUTDIR} && \
	    ls -l ${SHELL_OUTDIR}/*.diff | awk '{if( $$5 > 0 ) print}' ) || \
	    true

#------------------------------------------------------------------------------

clean:
	rm -f *~
	rm -f ${DIFF_FILES}
	rm -f ${SCRIPT_DIFFS}
	rm -f ${TST_DIFFS}
	rm -f ${SHELL_DIFFS}

cleanAll: clean ${LOCAL_CLEAN_TARGETS}
	rm -f ${YAPP_MODULES}

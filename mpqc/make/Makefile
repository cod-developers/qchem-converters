# --*- Makefile -*--

MAKECONF_FILES = ${filter-out %~, ${wildcard Makeconf*}}

ifneq ("${MAKECONF_FILES}","")
include ${MAKECONF_FILES}
endif

#------------------------------------------------------------------------------

COMS   = ${wildcard *.com}
LOGS   = ${COMS:%.com=%.log}
DEPEND = ${COMS:%.com=.%.d}

#------------------------------------------------------------------------------

.PHONY: all run clean cleanAll

all: run

include ${DEPEND}

#------------------------------------------------------------------------------

MAKELOCAL_FILES = ${filter-out %~, ${wildcard Makelocal*}}

ifneq ("${MAKELOCAL_FILES}","")
include ${MAKELOCAL_FILES}
endif

#------------------------------------------------------------------------------

run: ${LOGS}

#------------------------------------------------------------------------------

%.log: %.com
	./$< 2>&1 | tee $@

.%.d: %.com
	mkcomdepend $< > $@

%: %.log;

#------------------------------------------------------------------------------

clean:
	rm -f ${LOGS}

cleanAll: clean
	rm -f ${DEPEND}
	rm -f ${CLEAN_FILES}
	rm -f ${CLEAN_DIRS:%=%/*}

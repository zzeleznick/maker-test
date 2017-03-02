SHELL := $(shell which bash)
FILENAME="printvar.mk"

# $(info FILENAME="$(FILENAME)")

# PRINT MAKEFILE VARIABLE; Usage: make util-print-VARIABLE
util-print-%:
	@if [[ -z "$($*)" ]]; then \
		echo "'$*' does not seem to be a valid variable"; \
	else \
		echo "'$*=$($*)'"; \
	fi

# PRINT MAKEFILE VARIABLES
util-printvars:
	@$(foreach V,$(sort $(.VARIABLES)), \
		$(if $(filter-out environment% default automatic, \
		$(origin $V)),$(info $V=$($V) ($(origin $V)))))

# PRINT ENVIRONMENT VARIABLES
util-printenv:
	@$(foreach V,$(sort $(.VARIABLES)), \
		$(if $(filter-out file default automatic, \
		$(origin $V)),$(info $V=$($V) ($(origin $V)))))

# CHECK ENVIRONMENT VARIABLE
# Usage:
# my-target: env-guard-HOST
# where my-target depends on $HOST being set
util-envguard-%:
	@if [[ "$${${*}}" == "" ]]; then \
		echo "ERROR: Environment variable ${*} is not defined!"; \
		exit -1; \
	fi

util-help:
	@$(MAKE) -f 'Makefile' -p 2>/dev/null | \
		pcregrep -e '^[a-zA-Z0-9][^\$$#\t=]*:' | \
		pcregrep -v -e ':=' | \
		sed 's/:.*//' | \
		pcregrep -v -e 'make' | \
		pcregrep -v -e 'Makefile' | \
		pcregrep -v -e 'util-*' | \
		sort | \
		uniq | awk 1 ORS="\t" | \
		python -c 'import sys; \
		print("********  Available Commands  ********"); \
		print(sys.stdin.read().replace("\t", "\n").strip()); \
		print("********                      ********")'

util-help-%:
	$(info Grabbing info on "$*":)
	@./findr.sh "$*" | awk '{print}' | term="$*" ./findr.sh

util-more-help:
	@$(MAKE) -f "$(FILENAME)" -p | \
		pcregrep -e '^[a-zA-Z0-9][^\$$#\t=]*:' | \
		pcregrep -v -e ':=' | \
		sed 's/:.*//' | \
		pcregrep -v -e 'make' | \
		pcregrep -v -e 'Makefile' | \
		pcregrep -v -e "$(FILENAME)" | \
		sort | \
		uniq | awk 1 ORS="\t" | \
		python -c 'import sys; \
		print("********  Available Util Commands  ********"); \
		print(sys.stdin.read().replace("\t", "\n").strip()); \
		print("********                           ********")'


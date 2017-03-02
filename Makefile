SHELL := $(shell which bash)
PYTHON_VERSION := $(shell $(SHELL) blob.sh)
SUB_MAKEFILE="printvar.mk"

# I DO NOTHING
nothing:
	$(error Nothing to do here...)

# Display a list of commands; Usage: make help
help:
	$(info I am helping)
	$(info SHELL="$(SHELL)")
	$(info PYTHON_VERSION="$(PYTHON_VERSION)")
	@$(MAKE) -f "$(SUB_MAKEFILE)" -f 'Makefile' util-help

# Display help for a command; Usage: make help-COMMAND
help-%:
	@$(MAKE) -f "$(SUB_MAKEFILE)" -f 'Makefile' util-help-"$*"

# Print MAKEFILE VARIABLE; Usage: make print-VARIABLE
print-%:
	@$(MAKE) -f "$(SUB_MAKEFILE)" -f 'Makefile' util-print-"$*"

clean:
	rm *.txt

.PHONY: nothing help clean print-%
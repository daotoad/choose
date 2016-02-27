all:
	@echo "Run \"make install\" to install to your home directory"
	@echo "To set up your shell configuration, run \"choose config\""
	@echo "See README for instructions on installation or configuration"

test:
	t/harness.sh

test_bash:
	t/harness.sh /bin/bash

test_zsh:
	t/harness.sh /usr/bin/zsh

test_all: test_bash test_zsh


install:
	@[ -d $(HOME)/.choose/lib/core ] && echo "* Removing old $(HOME)/.choose/lib/core" && rm -rf $(HOME)/.choose/lib/core || true
	@echo "* Installing libraries to $(HOME)/.choose/lib"
	@mkdir -p $(HOME)/.choose/lib/core
	@cp -pr lib/core $(HOME)/.choose/lib
	@cp -pr lib/toolfiles $(HOME)/.choose/lib/toolfiles
	@cp   load_choose $(HOME)/.choose/load_choose
	@echo "* Run  source load_choose"
	@echo "Congratulations, choose is now installed"
	@echo

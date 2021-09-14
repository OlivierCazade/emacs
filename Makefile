.PHONY: all
all: generate-config

.PHONY: generate-config
generate-config :
	emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "./init.org")'

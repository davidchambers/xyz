SHELLCHECK = shellcheck
XYZ = ./xyz --repo git@github.com:davidchambers/xyz.git


.PHONY: lint
lint:
	$(SHELLCHECK) --version
	$(SHELLCHECK) -- xyz


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)

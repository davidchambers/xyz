SHELLCHECK = shellcheck
XYZ = ./xyz --repo git@github.com:davidchambers/xyz.git --publish-command 'read -r -p "One-time password: " && npm publish --otp "$$REPLY"'


.PHONY: lint
lint:
	$(SHELLCHECK) -- xyz


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)

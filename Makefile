XYZ = ./xyz --repo git@github.com:davidchambers/xyz.git


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)

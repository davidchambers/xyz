XYZ = ./xyz


.PHONY: release-major release-minor release-patch
release-major:
	$(XYZ) --increment major
release-minor:
	$(XYZ) --increment minor
release-patch:
	$(XYZ) --increment patch

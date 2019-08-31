
carthage_bootstrap:
	(cd OMDBApi/Dependencies && carthage bootstrap --platform iOS --use-submodules --no-use-binaries --no-build --verbose)

carthage_update:
	(cd OMDBApi/Dependencies && carthage update --platform iOS --use-submodules --no-use-binaries --no-build --verbose)

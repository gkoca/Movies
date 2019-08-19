#TODO: make it better
carthage_bootstrap:
	(cd OMDBApi/Dependencies && carthage bootstrap --platform iOS --use-submodules --no-use-binaries)
	(cd Movies/Dependencies && carthage bootstrap --platform iOS --cache-builds)
	rm -Rf Movies/Dependencies/Carthage/Checkouts

carthage_update:
	(cd OMDBApi/Dependencies && carthage update --platform iOS --use-submodules --no-use-binaries)
	(cd Movies/Dependencies && carthage update --platform iOS --cache-builds)
	rm -Rf Movies/Dependencies/Carthage/Checkouts

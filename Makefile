#TODO: make it better
#carthage_bootstrap:
#	(cd OMDBApi/Dependencies && carthage bootstrap --platform iOS --cache-builds)
#	(cd Movies/Dependencies && carthage bootstrap --platform iOS --cache-builds)
#	rm -Rf Movies/Dependencies/Carthage/Checkouts
#	rm -Rf OMDBApi/Dependencies/Carthage/Checkouts

#carthage_update:
#	(cd OMDBApi/Dependencies && carthage update --platform iOS --cache-builds)
#	(cd Movies/Dependencies && carthage update --platform iOS --cache-builds)
#	rm -Rf Movies/Dependencies/Carthage/Checkouts
#	rm -Rf OMDBApi/Dependencies/Carthage/Checkouts

carthage_bootstrap:
	(cd OMDBApi/Dependencies && carthage bootstrap --platform iOS --use-submodules --no-use-binaries)

carthage_update:
	(cd OMDBApi/Dependencies && carthage update --platform iOS --use-submodules --no-use-binaries)

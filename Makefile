PRH_BUNDLE?=$(shell which bundle)

all:
	
install:
	$(PRH_BUNDLE) install --path=.bundle
	$(PRH_BUNDLE) exec pod install

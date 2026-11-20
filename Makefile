TARGET := iphone:clang:latest:14.0
ARCHS := arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME := PlatoDNS
PlatoDNS_FILES := Tweak.xm
PlatoDNS_CFLAGS := -fobjc-arc
PlatoDNS_FRAMEWORKS := UIKit Foundation

# Standalone dylib: no MobileSubstrate / ElleKit dependency and no %hook of
# any host-app class, so this links and loads as a plain injected dylib via
# Sideloadly / TrollStore / Feather. There is nothing here to "install" on a
# jailbroken filesystem.
include $(THEOS_MAKE_PATH)/tweak.mk

all:
	$(MAKE) package

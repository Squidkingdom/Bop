#THEOS_DEVICE_IP = 192.168.1.131
THEOS_DEVICE_IP = 172.20.10.1
export ARCHS = arm64 arm64e
export TARGET = iphone:clang:13.0:10.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Bop
Bop_FILES = Tweak.xm
Bop_EXTRA_FRAMEWORKS += Cephei 
Bop_PRIVATE_FRAMEWORKS = MediaRemote

include $(THEOS_MAKE_PATH)/tweak.mk

#after-install::
	#install.exec "killall -9 SpringBoard"
SUBPROJECTS += boppreferences
include $(THEOS_MAKE_PATH)/aggregate.mk

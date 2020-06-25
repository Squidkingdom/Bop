include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BopPreferences

BopPreferences_FILES = BOPRootListController.m ../Bop.xm
BopPreferences_INSTALL_PATH = /Library/PreferenceBundles
BopPreferences_FRAMEWORKS = UIKit
BopPreferences_EXTRA_FRAMEWORKS += Cephei CepheiPrefs
BopPreferences_PRIVATE_FRAMEWORKS = Preferences MediaRemote
BopPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BopPreferences.plist$(ECHO_END)

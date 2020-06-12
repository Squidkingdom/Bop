include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BopPrefs

BopPrefs_FILES = BOPRootListController.m
BopPrefs_INSTALL_PATH = /Library/PreferenceBundles
BopPrefs_FRAMEWORKS = UIKit
BopPrefs_PRIVATE_FRAMEWORKS = Preferences
BopPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BopPrefs.plist$(ECHO_END)

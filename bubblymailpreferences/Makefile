include theos/makefiles/common.mk

BUNDLE_NAME = BubblyMailPreferences
BubblyMailPreferences_FILES = BubblyMailPreferences.mm TopColorController.m TopColorPane.m ExampleView.m
BubblyMailPreferences_INSTALL_PATH = /Library/PreferenceBundles
BubblyMailPreferences_FRAMEWORKS = UIKit CoreGraphics QuartzCore
BubblyMailPreferences_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BubblyMailPreferences.plist$(ECHO_END)

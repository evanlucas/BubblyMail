include theos/makefiles/common.mk
export GO_EASY_ON_ME=1

TWEAK_NAME = BubblyMail
BubblyMail_FILES = Tweak.xm
BubblyMail_FRAMEWORKS = UIKit CoreGraphics QuartzCore Foundation
SUBPROJECTS = bubblymailpreferences
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk

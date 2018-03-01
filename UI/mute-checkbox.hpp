#pragma once

#include <QCheckBox>
#include "visibility-checkbox.hpp"

class MuteCheckBox : public VisibilityCheckBox_Base {
	Q_OBJECT

public:
	MuteCheckBox() :
		VisibilityCheckBox_Base(
			":/res/images/mute.png",
			":/res/images/unmute.png",
			":/res/images/mute_focused.png",
			":/res/images/unmute_focused.png"
		)
	{
	}
};

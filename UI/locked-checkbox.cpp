#include <QPaintEvent>
#include <QPixmap>
#include <QPainter>
#include "locked-checkbox.hpp"

#include <util/c99defs.h>

LockedCheckBox::LockedCheckBox() : 
	VisibilityCheckBox_Base(
		":/res/images/locked_mask.png",
		":/res/images/unlocked_mask.png",
		":/res/images/locked_mask_focused.png",
		":/res/images/unlocked_mask_focused.png"
	)
{
}
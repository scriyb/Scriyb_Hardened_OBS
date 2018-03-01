#include <QCheckBox>
#include <QPixmap>
#include "visibility-checkbox.hpp"

class QPaintEvernt;

class LockedCheckBox : public VisibilityCheckBox_Base {
	Q_OBJECT

public:
	LockedCheckBox();
};
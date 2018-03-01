#include <QCheckBox>
#include <QPixmap>
#pragma once

class QPaintEvernt;

class VisibilityCheckBox_Base : public QCheckBox {
	Q_OBJECT

	QPixmap checkedImage;
	QPixmap uncheckedImage;
	QPixmap checkedFocusedImage;
	QPixmap uncheckedFocusedImage;

	bool justLostFocus;

public:
	VisibilityCheckBox_Base(const QString& checkedImagePath, const QString& uncheckedImagePath, const QString& checkedFocusedImagePath, const QString& uncheckedFocusedImagePath);

protected:
	virtual void paintEvent(QPaintEvent *event) override;
	virtual void focusOutEvent(QFocusEvent *event) override;
};

class VisibilityCheckBox : public VisibilityCheckBox_Base {
	Q_OBJECT

public:
	VisibilityCheckBox();
};

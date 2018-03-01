#include <QPaintEvent>
#include <QPixmap>
#include <QPainter>
#include "visibility-checkbox.hpp"

#include <util/c99defs.h>

VisibilityCheckBox_Base::VisibilityCheckBox_Base(const QString& checkedImagePath, const QString& uncheckedImagePath, const QString& checkedFocusedImagePath, const QString& uncheckedFocusedImagePath) :
	QCheckBox()
{
	checkedImage =
		QPixmap::fromImage(QImage(checkedImagePath));
	uncheckedImage =
		QPixmap::fromImage(QImage(uncheckedImagePath));
	
	checkedFocusedImage =
		QPixmap::fromImage(QImage(checkedFocusedImagePath));
	uncheckedFocusedImage =
		QPixmap::fromImage(QImage(uncheckedFocusedImagePath));

	justLostFocus = false;

	setMinimumSize(16, 16);

	setStyleSheet("outline: none;");
}

void VisibilityCheckBox_Base::paintEvent(QPaintEvent *event)
{
	UNUSED_PARAMETER(event);

	QPixmap* pixmap = isChecked() ? &checkedImage : &uncheckedImage;
	if (hasFocus() && !justLostFocus)
	{
		pixmap = isChecked() ? &checkedFocusedImage : &uncheckedFocusedImage;
	}
	justLostFocus = false;

	QImage image(pixmap->size(), QImage::Format_ARGB32);

	QPainter draw(&image);
	draw.setCompositionMode(QPainter::CompositionMode_Source);
	draw.drawPixmap(0, 0, pixmap->width(), pixmap->height(), *pixmap);
	draw.setCompositionMode(QPainter::CompositionMode_SourceIn);
	draw.fillRect(QRectF(QPointF(0.0f, 0.0f), pixmap->size()),
			palette().color(foregroundRole()));

	QPainter p(this);
	p.drawPixmap(0, 0, image.width(), image.height(),
			QPixmap::fromImage(image));
}

void VisibilityCheckBox_Base::focusOutEvent(QFocusEvent *event)
{
	QCheckBox::focusOutEvent(event);
	justLostFocus = true;
	repaint();
}

VisibilityCheckBox::VisibilityCheckBox() :
	VisibilityCheckBox_Base(
		":/res/images/visible_mask.png",
		":/res/images/invisible_mask.png",
		":/res/images/visible_mask_focused.png",
		":/res/images/invisible_mask_focused.png"
	)
{
}
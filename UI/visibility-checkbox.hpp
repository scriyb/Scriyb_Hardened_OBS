#include <QCheckBox>
#include <QPixmap>

class QPaintEvernt;

class VisibilityCheckBox : public QCheckBox {
	Q_OBJECT

	QPixmap checkedImage;
	QPixmap uncheckedImage;
	QPixmap checkedFocusedImage;
	QPixmap uncheckedFocusedImage;

	bool justLostFocus;

public:
	VisibilityCheckBox();

protected:
	virtual void paintEvent(QPaintEvent *event) override;
	virtual void focusOutEvent(QFocusEvent *event) override;
};

#include <QMouseEvent>

#include <vector>

#include "obs-app.hpp"
#include "qt-wrappers.hpp"
#include "source-list-widget.hpp"
#include "qpainter.h"

Q_DECLARE_METATYPE(OBSSceneItem);

void SourceListWidget::mouseDoubleClickEvent(QMouseEvent *event)
{
	if (event->button() == Qt::LeftButton)
		QListWidget::mouseDoubleClickEvent(event);
}

void SourceListWidget::dropEvent(QDropEvent *event)
{
	QListWidget::dropEvent(event);
	if (!event->isAccepted() || !count())
		return;

	auto GetSceneItem = [&](int i)
	{
		return item(i)->data(Qt::UserRole).value<OBSSceneItem>();
	};

	std::vector<obs_sceneitem_t*> newOrder;
	newOrder.reserve(count());
	for (int i = count() - 1; i >= 0; i--)
		newOrder.push_back(GetSceneItem(i));

	auto UpdateOrderAtomically = [&](obs_scene_t *scene)
	{
		ignoreReorder = true;
		obs_scene_reorder_items(scene, newOrder.data(),
				newOrder.size());
		ignoreReorder = false;
	};
	using UpdateOrderAtomically_t = decltype(UpdateOrderAtomically);

	auto scene = obs_sceneitem_get_scene(GetSceneItem(0));
	obs_scene_atomic_update(scene, [](void *data, obs_scene_t *scene)
	{
		(*static_cast<UpdateOrderAtomically_t*>(data))(scene);
	}, static_cast<void*>(&UpdateOrderAtomically));
}

void SourceListWidget::paintEvent(QPaintEvent *e) 
{
	QListView::paintEvent(e);
	if (!model()) return;

	//HACK: Always populate sources list with an item to make it more screen-reader friendly
	if (model()->rowCount(rootIndex()) == 0)
	{
		if (!emptyListItem)
		{
			emptyListItem = new QListWidgetItem();
			emptyListItem->setText(QTStr("Basic.Main.NoSources"));
		}

		addItem(emptyListItem);
	}
	else if(model()->rowCount(rootIndex()) >= 2)
	{
		for (int i = 0; i < count(); ++i)
		{
			if (item(i) == emptyListItem)
			{
				takeItem(i);
				break;
			}
		}
	}

	//HACK: Make sure an item is always handled as selected (also for screen-reader friendliness)
	setCurrentItem(currentItem());

	//HACK: Make sure items have some sort of screen-reader accessible name
	/*for (int i = 0; i < count(); ++i)
	{
		QString str;
		item(i)->setText(str.sprintf("Source %d", i + 1));
	}*/
}
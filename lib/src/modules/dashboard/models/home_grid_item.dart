import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';

class HomeGridItem {
  final int id;
  final String title;
  final String image;
  final HomeGridItemType type;

  HomeGridItem(this.id, this.title, this.image, this.type);
}

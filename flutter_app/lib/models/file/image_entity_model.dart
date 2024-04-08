import 'package:photo_manager/photo_manager.dart';

class ImageEntity {
  final AssetEntity entity;
  bool isSelected;

  ImageEntity({required this.entity, this.isSelected = false});
}

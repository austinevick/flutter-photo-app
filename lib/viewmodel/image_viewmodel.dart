import 'package:pixabay_collection/model/image.dart';

class ImageViewModel {
  final ImageModel _imageModel;
  ImageViewModel({ImageModel imageModel}) : _imageModel = imageModel;

  String get tags => _imageModel.tags;
  String get favourites => _imageModel.favourites;
  String get imageUrl => _imageModel.imageUrl;
  String get likes => _imageModel.likes;
  String get id => _imageModel.id.toString();
}

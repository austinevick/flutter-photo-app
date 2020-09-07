import 'package:flutter/cupertino.dart';
import 'package:pixabay_collection/model/image.dart';
import 'package:pixabay_collection/viewmodel/image_viewmodel.dart';
import 'package:pixabay_collection/webservice/webservice.dart';

class ImageListViewModel with ChangeNotifier {
  List<ImageViewModel> imageList = List<ImageViewModel>();

  Future<void> populateImageList() async {
    List<ImageModel> images = await Webservice().fetchJsonData();
    this.imageList =
        images.map((image) => ImageViewModel(imageModel: image)).toList();
    notifyListeners();
  }

  Future<void> getImageByKeyword(String keyword) async {
    List<ImageModel> image = await Webservice().fetchImageByKeyword(keyword);
    this.imageList =
        image.map((images) => ImageViewModel(imageModel: images)).toList();
    notifyListeners();
  }

  int get imageLenght => imageList.length;
}

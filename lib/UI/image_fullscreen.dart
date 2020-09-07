import 'package:flutter/material.dart';

import 'package:pixabay_collection/viewmodel/image_viewmodel.dart';

class ImageFullScreen extends StatelessWidget {
  final ImageViewModel imageViewModel;

  const ImageFullScreen({Key key, this.imageViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageViewModel.tags),
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Hero(
          tag: imageViewModel.id,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageViewModel.imageUrl))),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pixabay_collection/UI/image_fullscreen.dart';
import 'package:pixabay_collection/viewmodel/image_listviewmodel.dart';
import 'package:provider/provider.dart';

class ImageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ImageListViewModel>(context);

    return p.imageList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(PageRouteBuilder(
                    reverseTransitionDuration: Duration(seconds: 2),
                    fullscreenDialog: true,
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) =>
                            FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                    pageBuilder: (context, animation, secondaryAnimatiom) {
                      return ImageFullScreen(imageViewModel: p.imageList[i]);
                    })),
                child: Hero(
                  tag: p.imageList[i].id,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black26, BlendMode.darken),
                              fit: BoxFit.cover,
                              image: NetworkImage(p.imageList[i].imageUrl))),
                    ),
                  ),
                ),
              );
            },
            itemCount: p.imageList.length);
  }
}

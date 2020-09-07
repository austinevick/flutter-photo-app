import 'package:flutter/material.dart';
import 'package:pixabay_collection/viewmodel/image_listviewmodel.dart';
import 'package:provider/provider.dart';

import 'image_fullscreen.dart';

class ImageSearchScreen extends StatefulWidget {
  @override
  _ImageSearchScreenState createState() => _ImageSearchScreenState();
}

class _ImageSearchScreenState extends State<ImageSearchScreen> {
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ImageListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              style: TextStyle(fontSize: 22),
              decoration: InputDecoration(
                  hintText: 'Search',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
              onChanged: (value) {
                p.getImageByKeyword(value);
              },
            ),
          ),
        ),
        body: p.imageList.isEmpty
            ? Container(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Text(
                    'No results for' " '${controller.text}' ",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
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
                          return ImageFullScreen(
                              imageViewModel: p.imageList[i]);
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
                                  image:
                                      NetworkImage(p.imageList[i].imageUrl))),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: p.imageList.length));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';

import 'package:pixabay_collection/viewmodel/image_viewmodel.dart';
import 'package:wallpaper/wallpaper.dart';

class ImageFullScreen extends StatefulWidget {
  final ImageViewModel imageViewModel;

  const ImageFullScreen({Key key, this.imageViewModel}) : super(key: key);

  @override
  _ImageFullScreenState createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  Stream<String> progressString;
  String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: FlatButton(
                          onPressed: () => setImageAsWallpaper(
                              widget.imageViewModel.imageUrl),
                          child: Text('Set as wallpaper')),
                    ),
                    PopupMenuItem(
                      child: FlatButton(
                          onPressed: () =>
                              downloadImage(widget.imageViewModel.imageUrl),
                          child: Text('Save to storage')),
                    )
                  ]),
        ],
        title: Text(widget.imageViewModel.tags),
      ),
      body: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Hero(
          tag: widget.imageViewModel.id,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget.imageViewModel.imageUrl))),
          ),
        ),
      ),
    );
  }

  downloadImage(String url) async {
    try {
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) return;
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  setImageAsWallpaper(String url) {
    progressString = Wallpaper.ImageDownloadProgress(url);
    progressString.listen((event) {
      setState(
        () {
          res = event;
          downloading = true;
        },
      );
    }, onDone: () async {
      await Wallpaper.homeScreen();
      setState(() => downloading = false);
    }, onError: (error) {
      setState(() => downloading = false);
    });
  }

  Widget dialog() {
    return Dialog(
      child: downloading
          ? Container(
              height: 50.0,
              width: 200.0,
              child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 20.0),
                    Text(
                      "Downloading File : $res",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            )
          : Text(""),
    );
  }
}

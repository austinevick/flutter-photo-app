import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:pixabay_collection/UI/image_fullscreen.dart';
import 'package:pixabay_collection/UI/image_searchscreen.dart';
import 'package:pixabay_collection/viewmodel/image_listviewmodel.dart';
import 'package:pixabay_collection/widgets/image_gridview.dart';
import 'package:pixabay_collection/widgets/image_listview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ImageListViewModel>(
      context,
      listen: false,
    ).populateImageList();
    SchedulerBinding.instance.window;
    super.initState();
  }

  bool showGridView = false;
  onToggle() {
    setState(() => showGridView = !showGridView);
  }

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<ImageListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Collection'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: showGridView ? Icon(Icons.list) : Icon(Icons.grid_on),
                onPressed: onToggle),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageSearchScreen()));
                }),
          )
        ],
      ),
      body: showGridView ? ImageGridView() : ImageListView(),
    );
  }
}

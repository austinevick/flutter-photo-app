import 'dart:convert';

import 'package:http/http.dart';
import 'package:pixabay_collection/model/image.dart';

class Webservice {
  final String url =
      'https://pixabay.com/api/?key=14864619-923ee1204c9967979dc2d22bf&q=yellow+flowers&image_type=photo&pretty=true#';
  Future fetchJsonData() async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      Iterable list = result['hits'];
      return list.map((image) => ImageModel.fromJson(image)).toList();
    } else {
      throw Exception('error fetching data');
    }
  }

  Future fetchImageByKeyword(String keyword) async {
    final String url =
        'https://pixabay.com/api/?key=14864619-923ee1204c9967979dc2d22bf&q=$keyword&image_type=photo&pretty=true#';
    Response response = await get(url);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result['hits'];
      return list.map((image) => ImageModel.fromJson(image)).toList();
    }
    throw Exception('error fetching data');
  }
}

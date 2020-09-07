class ImageModel {
  final int id;
  final String imageUrl;
  final String favourites;
  final String likes;
  final String tags;

  ImageModel({this.id, this.imageUrl, this.favourites, this.likes, this.tags});
  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
        id: map['id'],
        imageUrl: map['largeImageURL'],
        favourites: map['favorites'].toString(),
        likes: map['likes'].toString(),
        tags: map['tags']);
  }
}

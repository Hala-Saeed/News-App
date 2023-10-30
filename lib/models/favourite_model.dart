class FavouriteModel {
  String title, publishedAt, docId, description, urlToImage, source;

  FavouriteModel(
      {required this.title,
        required this.publishedAt,
        required this.urlToImage,
        required this.docId,
        required this.source,
        required this.description,
      });

  factory FavouriteModel.fromMap(Map<String, dynamic> map) =>
      FavouriteModel(
        title :  map['userName'] ?? ' ',
        urlToImage :  map['phoneNumber'] ?? ' ',
        publishedAt : map['profileUrl'] ?? '',
        docId : map['uid'] ?? '',
        source : map['source'] ?? '',
        description : map['occupation'] ?? '',
      );


  Map<String, dynamic> toMap() => {
    'userName' : title,
    'phoneNumber' : urlToImage,
    'profileUrl': publishedAt,
    'uid': docId,
    'source': source,
    'occupation': description,
  };


}

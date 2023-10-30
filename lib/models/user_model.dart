class UserModel {
  String userName, profileUrl, uid, occupation, phoneNumber;

  UserModel(
      {required this.userName,
        required this.profileUrl,
        required this.phoneNumber,
        required this.uid,
        required this.occupation,
      });

  factory UserModel.fromMap(Map<String, dynamic> map) =>
      UserModel(
        userName :  map['userName'] ?? ' ',
        phoneNumber :  map['phoneNumber'] ?? ' ',
        profileUrl : map['profileUrl'] ?? '',
        uid : map['uid'] ?? '',
        occupation : map['occupation'] ?? '',
      );


  Map<String, dynamic> toMap() => {
    'userName' : userName,
    'phoneNumber' : phoneNumber,
    'profileUrl': profileUrl,
    'uid': uid,
    'occupation': occupation,
  };


}

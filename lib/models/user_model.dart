import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String loc;
  String username;
  String photoURL;

  UserModel(
      {required this.uid,
      required this.email,
      required this.loc,
      required this.photoURL,
      required this.username});

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'loc': loc,
        'photoURL': photoURL
      };

  ///
  static UserModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      email: snapshot['email'],
      photoURL: snapshot['photoURL'],
      loc: snapshot['loc'],
    );
  }
}

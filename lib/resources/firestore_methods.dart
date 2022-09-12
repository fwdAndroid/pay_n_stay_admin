import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // //Upload PostImage to Firestore
  // Future<String> uploadPosts(Uint8List file, String description, String uid,
  //     String username, String profileImage) async {
  //   String res = "Some Error";
  //   try {
  //     String photoUrl =
  //         await StorageMethods().uploadImageToStorage("postImages", file, true);

  //     String postId = Uuid().v1();
  //     PostModel postModel = PostModel(
  //         description: description,
  //         uid: uid,
  //         username: username,
  //         postId: postId,
  //         datePublished: DateTime.now(),
  //         postUrl: photoUrl,
  //         profileImage: profileImage,
  //         likes: []);

  //     ///Uploading Post To Firebase
  //     _firebaseFirestore
  //         .collection('posts')
  //         .doc(postId)
  //         .set(postModel.toJson());
  //     res = 'Sucessfully Uploaded in Firebase';
  //   } catch (e) {
  //     res = e.toString();
  //   }

  //   return res;
  // }
//Update Category
  void updateCetagories(
      {String? cetagory, String? subcetagory, String? docid}) {
    if (cetagory == "" || subcetagory == "") {
    } else {
      _firebaseFirestore
          .collection("categories")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("categorylist").doc(docid).update({
        'category': cetagory?.toLowerCase(),
        'subcategory': subcetagory?.toLowerCase(),
      }).catchError((e) {
        print(e);
      });
    }
  }

//Add Category
  void addCetagories({String? cetagory, String? subcetagory}) {
    if (cetagory == "" || subcetagory == "") {
    } else {
      _firebaseFirestore
          .collection("categories")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("categorylist")
          .add({
        'category': cetagory?.toLowerCase(),
        'subcategory': subcetagory?.toLowerCase(),
      }).catchError((e) {
        print(e);
      });
    }
  }
  //Save Food item data
  void saveData({String? price,String? type,String? cetagory,String? subcetagory,String? title,String? description,String? imageUrl  }){
    _firebaseFirestore.collection('foodcategory').add({
 'imageUrl':imageUrl ,
 'price':price,
      'cetagory' :cetagory,
      'subcetagory':subcetagory
      , 'title':title,
 'description':description,
      'isActive':true,
      'fav':false

    }).catchError((e){
      print(e);
    });
  }
}

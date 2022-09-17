import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/resources/firestore_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditFoodItem extends StatefulWidget {
  String docId;
  String? price;
  String? type;
  String? category;
  String? title;

  String? description;
  String? imageUrl;
  EditFoodItem(
      {Key? key,
      required this.docId,
      this.title,
      this.category,
      this.price,
      this.imageUrl,
      this.type,
      this.description})
      : super(key: key);

  @override
  _EditFoodItemState createState() => _EditFoodItemState();
}

class _EditFoodItemState extends State<EditFoodItem> {
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String cetagoryValue = "";
  String? category;
  String? subCetagoryValue;
  String? imageLink;
  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  TextEditingController priceController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController describeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    priceController.text = widget.price!;
    titleController.text = widget.title!;
    describeController.text = widget.description!;
    cetagoryValue = widget.category!;
    subCetagoryValue = widget.type;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: [
          InkWell(
            onTap: addImage,
            child: Container(
              // color: Colors.amber,
              height: 124,
              width: 318,
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              decoration: BoxDecoration(
                  color: Color(0xffF8B800),

                  //  border: Border.all(

                  //  ),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: widget.imageUrl == null
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset('assets/blackadd.png'),
                      Container(
                        child: Text('Add Images',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      )
                    ])
                  : Image.network(
                      widget.imageUrl!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Edit title *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    // hintText: 'Type someting here',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none),
                onChanged: (value) {},
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Edit Category *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("categorylist")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text("Please wait");
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                      ),
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: widget.category,
                    ),
                    value: cetagoryValue,
                    onChanged: (newValue) {
                      setState(() {
                        cetagoryValue = newValue.toString();
                      });
                      print(cetagoryValue);
                    },
                    items: snapshot.data!.docs
                        .map((DocumentSnapshot doc) => DropdownMenuItem(
                            value: doc.get('category'),
                            child: Text("${doc.get('category')}")))
                        .toList(),
                  ),
                );
              }),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Edit Sub Category *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("categorylist")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text("Please wait");
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                      ),
                      // filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: widget.type,
                    ),
                    value: subCetagoryValue,
                    onSaved: (newValue) {
                      setState(() {
                        subCetagoryValue = newValue.toString();
                      });
                    },
                    onChanged: (newValue) {
                      setState(() {
                        subCetagoryValue = newValue.toString();
                      });
                    },
                    items: snapshot.data!.docs
                        .map((DocumentSnapshot doc) => DropdownMenuItem(
                            value: doc.get('subcategory'),
                            child: Text("${doc.get('subcategory')}")))
                        .toList(),
                  ),
                );
              }),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              ' Edit Price *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Container(
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                controller: priceController,
                decoration: InputDecoration(
                    // hintText: 'Type someting here',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none),
                onChanged: (value) {},
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Describe what are you selling *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: Container(
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                controller: describeController,
                decoration: InputDecoration(
                    // hintText: 'Type someting here',
                    contentPadding: EdgeInsets.all(20),
                    border: InputBorder.none),
                onChanged: (value) {},
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 80, vertical: 20),
            child: ElevatedButton(
              onPressed: () async {
                if (priceController.text.isEmpty ||
                    titleController.text.isEmpty ||
                    describeController.text.isEmpty) {
                  showSnakBar("Both Fields are Required", context);
                } else if (imageUrl == null) {
                  showDialogBox(context);
                  FirestoreMethods().updateData(
                      docid: widget.docId,
                      title: titleController.text,
                      cetagory: cetagoryValue.toLowerCase(),
                      description: describeController.text,
                      price: priceController.text,
                      subcetagory: subCetagoryValue!.toLowerCase(),
                      imageUrl: imageLink ?? widget.imageUrl);
                  Navigator.pop(context);

                  showSnakBar("Your Post Successfully Updated", context);
                  Navigator.pop(context);
                } else {
                  showDialogBox(context);
                  await uploadImageToFirebase();
                  Navigator.pop(context);
                  FirestoreMethods().updateData(
                      docid: widget.docId,
                      title: titleController.text,
                      cetagory: cetagoryValue.toLowerCase(),
                      description: describeController.text,
                      price: priceController.text,
                      subcetagory: subCetagoryValue!.toLowerCase(),
                      // type: provider.typeController.text,
                      imageUrl: imageLink ?? widget.imageUrl);
                  showSnakBar("Your Post Successfully Updated", context);

                  closeDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: StadiumBorder(),
                fixedSize: Size(245, 60),
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
                // color: Color(0xffF8B800),
              ),
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future uploadImageToFirebase() async {
    File fileName = imageUrl!;
    var uuid = Uuid();
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('cetagory/images+${uuid.v4()}');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(fileName);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() async {
      print(fileName);
      String img = await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        imageLink = img;
      });
    });
  }
}

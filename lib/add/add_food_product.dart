import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/providers/allControlers.dart';
import 'package:pay_n_stay_admin/resources/firestore_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:uuid/uuid.dart';

class AddFoodProduct extends StatefulWidget {
  AddFoodProduct({Key? key}) : super(key: key);

  @override
  _AddFoodProductState createState() => _AddFoodProductState();
}

class _AddFoodProductState extends State<AddFoodProduct> {
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String? imageLink;
  String? category;
  void addImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  String? cetagoryValue;
  String? subCetagoryValue;
  @override
  Widget build(BuildContext context) {
    List<String> cityList = [
      'Ajman',
      'Al Ain',
      'Dubai',
      'Fujairah',
      'Ras Al Khaimah',
      'Sharjah',
      'Umm Al Quwain'
    ];
    var provider = Provider.of<AllControlers>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(children: [
          InkWell(
            onTap: () async {
              addImage();
            },
            child: imageUrl == null
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://static.remove.bg/remove-bg-web/a6eefcd21dff1bbc2448264c32f7b48d7380cb17/assets/start_remove-c851bdf8d3127a24e2d137a55b1b427378cd17385b01aec6e59d5d4b5f39d2ec.png'),
                    ),
                  ])
                : Image.file(
                    imageUrl!,
                    width: 300,
                    height: 300,
                  ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              'Add title *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                controller: provider.titleController,
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
              'Select Category *',
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
                      hintText: "Category",
                    ),
                    value: cetagoryValue,
                    onChanged: (newValue) {
                      setState(() {
                        cetagoryValue = newValue.toString();
                      });
                      print(newValue.toString());
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
              'Select Sub Category *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("categories")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("categorylist")
                  .where('category', isEqualTo: cetagoryValue)
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
                      hintText: "Sub Category",
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
              'Enter Food ITem Price *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: provider.priceController,
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
              'Enter Food item Detail *',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 373,
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid)),
              child: TextField(
                controller: provider.describeController,
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
                if (provider.priceController.text.isEmpty ||
                    provider.titleController.text.isEmpty ||
                    provider.describeController.text.isEmpty) {
                  showSnakBar("Both Fields are Required", context);
                } else {
                  showDialogBox(context);
                  await uploadImageToFirebase().then((value) {
                    FirestoreMethods().saveData(
                        title: provider.titleController.text,
                        cetagory: cetagoryValue ?? "",
                        description: provider.describeController.text,
                        price: provider.priceController.text,
                        type: provider.typeController.text,
                        imageUrl: imageLink,
                        subcetagory: subCetagoryValue ?? "");
                    showSnakBar("Post Successfully saved", context);
                    provider.clearControllers();
                    closeDialog(context);
                    closeDialog(context);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                fixedSize: Size(245, 70),
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
        .child('category/images+${uuid.v4()}');
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

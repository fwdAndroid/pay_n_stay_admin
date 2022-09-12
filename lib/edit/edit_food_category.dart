import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/resources/firestore_methods.dart';

class EditFoodCategory extends StatefulWidget {
  const EditFoodCategory({Key? key}) : super(key: key);

  @override
  _EditFoodCategoryState createState() => _EditFoodCategoryState();
}

class _EditFoodCategoryState extends State<EditFoodCategory> {
  TextEditingController cetagoryController = TextEditingController();
  TextEditingController subCetagoryController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cetagoryController.dispose();
    subCetagoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Manage Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("categories")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("categorylist")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Error Accured");
          } else if (snapshot.data == null) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];

                  return ListTile(
                    leading: InkWell(
                        onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              cetagoryController.text = ds['category'];
                              subCetagoryController.text = ds['subcategory'];
                              return AlertDialog(
                                title: const Text(
                                  'Edit Categories',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: const Text(
                                  'You can Edit Categories \n SubCatgories of the product',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12),
                                ),
                                actions: <Widget>[
                                  TextField(
                                    // autovalidateMode: AutovalidateMode.always,
                                    controller: cetagoryController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.category),
                                      hintText: 'Enter Category',
                                    ),
                                  ),
                                  TextField(
                                    // autovalidateMode: AutovalidateMode.always,
                                    controller: subCetagoryController,
                                    decoration: const InputDecoration(
                                      icon: Icon(Icons.category),
                                      hintText: 'Enter Sub Category',
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          if (cetagoryController.text.isEmpty) {
                                            showSnakBar(
                                                "Category required", context);
                                          } else if (subCetagoryController
                                              .text.isEmpty) {
                                            showSnakBar("SubCategory required",
                                                context);
                                          } else if (subCetagoryController
                                                  .text.isEmpty &&
                                              cetagoryController.text.isEmpty) {
                                            showSnakBar(
                                                "Both fields are required",
                                                context);
                                          } else {
                                            showDialogBox(context);
                                            FirestoreMethods().updateCetagories(
                                                docid: ds.id,
                                                cetagory:
                                                    cetagoryController.text,
                                                subcetagory:
                                                    subCetagoryController.text);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            showSnakBar(
                                                "Category is Successfully Updated",
                                                context);
                                            cetagoryController.clear();
                                            subCetagoryController.clear();
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text('OK'),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'))
                                    ],
                                  )
                                ],
                              );
                            }),
                        child: Icon(Icons.edit)),
                    title: Text(ds['category']),
                    subtitle: Text(ds['subcategory']),
                    trailing: InkWell(
                        onTap: () async {
                          await FirebaseFirestore.instance
                              .collection("categories")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection("categorylist")
                              .doc(ds.id)
                              .delete()
                              .then((value) => showSnakBar(
                                  "Cetagory deleted sucessffully", context));
                        },
                        child: Icon(Icons.delete)),
                  );
                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

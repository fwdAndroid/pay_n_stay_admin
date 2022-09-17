import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Screens/add_stock.dart';
import 'package:pay_n_stay_admin/Screens/login.dart';
import 'package:pay_n_stay_admin/Screens/orders/orders.dart';
import 'package:pay_n_stay_admin/Screens/product_detail.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/add/add_food_product.dart';
import 'package:pay_n_stay_admin/edit/edit_food_category.dart';
import 'package:pay_n_stay_admin/edit/edit_food_item.dart';
import 'package:pay_n_stay_admin/resources/firestore_methods.dart';
import 'package:pay_n_stay_admin/show/show.dart';

import '../Utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    var Size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (builder) => AddFoodProduct()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          TextButton(
              onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                        'Add Categories',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: const Text(
                        'You can add Categories \n SubCatgories of the product',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                      actions: <Widget>[
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          controller: cetagoryController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.category),
                            hintText: 'Enter Category',
                          ),
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
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
                                  showSnakBar("Category required", context);
                                } else if (subCetagoryController.text.isEmpty) {
                                  showSnakBar("SubCategory required", context);
                                } else if (subCetagoryController.text.isEmpty &&
                                    cetagoryController.text.isEmpty) {
                                  showSnakBar(
                                      "Both fields are required", context);
                                } else {
                                  showDialogBox(context);
                                  FirestoreMethods().addCetagories(
                                      cetagory: cetagoryController.text,
                                      subcetagory: subCetagoryController.text);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  showSnakBar("Category is Successfully added",
                                      context);
                                  cetagoryController.clear();
                                  subCetagoryController.clear();
                                }
                              },
                              child: const Text('OK'),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (builder) =>
                                              EditFoodCategory()));
                                },
                                child: Text('Edit'))
                          ],
                        )
                      ],
                    ),
                  ),
              child: Text("Add Category")),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => OrdersList()));
              },
              icon: Icon(
                Icons.shop,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) => {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (builder) => LoginAdmin()))
                    });
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                showDialogBox(context);
              },
              child: Text(
                'FastFood',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("FoodsItems")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('foodcategory')
                    .where('cetagory', isEqualTo: 'fastfood')
                    .where("isActive", isEqualTo: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  } else if (snapshot.data!.size == 0) {
                    return Center(child: Text("No Fast Food Item is included"));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error Accurred"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //  margin: EdgeInsets.only(bottom: 80),
                                  height: Size.height * 0.12,
                                  width: Size.width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(ds['imageUrl'],
                                              scale: 8),
                                          fit: BoxFit.cover)),
                                  child: GestureDetector(
                                    /// DEscription Detail Of Products
                                    onTap: () {},
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 7, bottom: 2, left: 10),
                                  child: Text(
                                    ds['title'] + " " + ds['cetagory'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    ds['subcetagory'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),

                                ////EDit Producrts
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProductOverview(
                                                        cetagory:
                                                            ds['cetagory'],
                                                        description:
                                                            ds['description'],
                                                        imageUrl:
                                                            ds['imageUrl'],
                                                        price: ds['price'],
                                                        title: ds['title'],
                                                        type: ds['subcetagory'],
                                                      )));
                                        },
                                        child: Text("View")),
                                    TextButton(
                                      child: Text("Edit"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    EditFoodItem(
                                                      docId: ds.id,
                                                      category: ds['cetagory'],
                                                      description:
                                                          ds['description'],
                                                      imageUrl: ds['imageUrl'],
                                                      price: ds['price'],
                                                      title: ds['title'],
                                                      type: ds['subcetagory'],
                                                    )));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                },
              ),
            ),
          ),
          //Continental
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                showDialogBox(context);
              },
              child: Text(
                'Continental',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   //  Show All Categories Product
          //   onTap: () {
          //     // Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (builder) => ShowAll(
          //     //               cetagory: 'laptop',
          //     //             )));
          //   },
          //   child: Container(
          //     margin: EdgeInsets.symmetric(horizontal: 20),
          //     child: Text(
          //       'Show all',
          //       style: TextStyle(
          //           color: Colors.black,
          //           fontSize: 13,
          //           fontWeight: FontWeight.bold),
          //     ),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("FoodsItems")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('foodcategory')
                    .where('cetagory', isEqualTo: 'continental')
                    .where("isActive", isEqualTo: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  } else if (snapshot.data!.size == 0) {
                    return Center(
                        child: Text("No Continental Item is included"));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error Accurred"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //  margin: EdgeInsets.only(bottom: 80),
                                  height: Size.height * 0.12,
                                  width: Size.width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(ds['imageUrl'],
                                              scale: 8),
                                          fit: BoxFit.cover)),
                                  child: GestureDetector(
                                    /// DEscription Detail Of Products
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (builder) =>
                                      //             ProductOverview(
                                      //               cetagory: ds['cetagory'],
                                      //               description:
                                      //                   ds['description'],
                                      //               imageUrl: ds['imageUrl'],
                                      //               price: ds['price'],
                                      //               title: ds['title'],
                                      //               type: ds['subcetagory'],
                                      //             )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 7, bottom: 2, left: 10),
                                  child: Text(
                                    ds['title'] + " " + ds['cetagory'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    ds['subcetagory'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),

                                ////EDit Producrts
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProductOverview(
                                                        cetagory:
                                                            ds['cetagory'],
                                                        description:
                                                            ds['description'],
                                                        imageUrl:
                                                            ds['imageUrl'],
                                                        price: ds['price'],
                                                        title: ds['title'],
                                                        type: ds['subcetagory'],
                                                      )));
                                        },
                                        child: Text("View")),
                                    TextButton(
                                      child: Text("Edit"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    EditFoodItem(
                                                      docId: ds.id,
                                                      category: ds['cetagory'],
                                                      description:
                                                          ds['description'],
                                                      imageUrl: ds['imageUrl'],
                                                      price: ds['price'],
                                                      title: ds['title'],
                                                      type: ds['subcetagory'],
                                                    )));
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                },
              ),
            ),
          ),
          //All Products
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                showDialogBox(context);
              },
              child: Text(
                'All Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 4.2,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("FoodsItems")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('foodcategory')
                    .where('cetagory', isNotEqualTo: '[fastfood,continental]')
                    .where("isActive", isEqualTo: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
                  } else if (snapshot.data!.size == 0) {
                    return Center(child: Text("No FoodItem Item is included"));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error Accurred"));
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  //  margin: EdgeInsets.only(bottom: 80),
                                  height: Size.height * 0.12,
                                  width: Size.width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(ds['imageUrl'],
                                              scale: 8),
                                          fit: BoxFit.cover)),
                                  child: GestureDetector(
                                    /// DEscription Detail Of Products
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (builder) =>
                                      //             ProductOverview(
                                      //               cetagory: ds['cetagory'],
                                      //               description:
                                      //                   ds['description'],
                                      //               imageUrl: ds['imageUrl'],
                                      //               price: ds['price'],
                                      //               title: ds['title'],
                                      //               type: ds['subcetagory'],
                                      //             )));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 7, bottom: 2, left: 10),
                                  child: Text(
                                    ds['title'] + " " + ds['cetagory'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    ds['subcetagory'],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 13),
                                  ),
                                ),

                                ////EDit Producrts
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (builder) =>
                                                      ProductOverview(
                                                        cetagory:
                                                            ds['cetagory'],
                                                        description:
                                                            ds['description'],
                                                        imageUrl:
                                                            ds['imageUrl'],
                                                        price: ds['price'],
                                                        title: ds['title'],
                                                        type: ds['subcetagory'],
                                                      )));
                                        },
                                        child: Text("View")),
                                    TextButton(
                                      child: Text("Edit"),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (builder) =>
                                                    EditFoodItem(
                                                      docId: ds.id,
                                                      category: ds['cetagory'],
                                                      description:
                                                          ds['description'],
                                                      imageUrl: ds['imageUrl'],
                                                      price: ds['price'],
                                                      title: ds['title'],
                                                      type: ds['subcetagory'],
                                                    )));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Screens/add_stock.dart';
import 'package:pay_n_stay_admin/Screens/login.dart';
import 'package:pay_n_stay_admin/Screens/orders/orders.dart';
import 'package:pay_n_stay_admin/Screens/product_detail.dart';
import 'package:pay_n_stay_admin/Utils/utils.dart';
import 'package:pay_n_stay_admin/edit/edit_food_category.dart';
import 'package:pay_n_stay_admin/resources/firestore_methods.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => LoginAdmin()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.black,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
                width: 300,
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey)),
                ),
              ),
              Text(
                'Sort',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "My Products",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 50,
                    crossAxisSpacing: 10),
                itemBuilder: (ctx, i) => InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => Product_detail()));
                  },
                  child: Card(
                    elevation: 5,
                    // color: white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.asset(
                              'asset/sss.png',
                              fit: BoxFit.cover,
                              height: 120,
                              width: double.infinity,
                            )),
                        Text(
                          'Chicken Burger\n\$ 450.00',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ]),
      )),
    );
  }
}

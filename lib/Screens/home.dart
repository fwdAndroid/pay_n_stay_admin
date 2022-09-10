import 'package:flutter/material.dart';
import 'package:pay_n_stay_admin/Screens/add_stock.dart';
import 'package:pay_n_stay_admin/Screens/login.dart';
import 'package:pay_n_stay_admin/Screens/orders/orders.dart';
import 'package:pay_n_stay_admin/Screens/product_detail.dart';

import '../Utils/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(
              color: black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Add_Stock()));
              },
              icon: Icon(
                Icons.add,
                color: black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Add_Stock()));
              },
              icon: Icon(
                Icons.edit,
                color: black,
              )),
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
                color: black,
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
                        color: grey,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: grey)),
                ),
              ),
              Text(
                'Sort',
                style: TextStyle(
                    color: grey, fontSize: 14, fontWeight: FontWeight.w400),
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
                          style: TextStyle(fontSize: 12, color: black),
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

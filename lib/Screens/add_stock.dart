// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:pay_n_stay_admin/Screens/home.dart';

class Add_Stock extends StatelessWidget {
  Add_Stock({Key? key}) : super(key: key);
  var DropDownC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Add Category and Menu',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DottedBorder(
                    color: Colors.black,
                    strokeWidth: 1,
                    borderType: BorderType.RRect,
                    radius: Radius.circular(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Container(
                          height: 100,
                          width: 100,
                          child: IconButton(
                              onPressed: () {},
                              icon: Image.asset('asset/bxs_camera-plus.png'))),
                    ),
                  ),
                  SizedBox(width: 50),
                  Text(
                    'Add Image',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              textfield('Enter Table No'),
              SizedBox(height: 10),
              textfield('Enter Floor'),
              SizedBox(height: 10),
              textfield('Enter Menu Category'),
              SizedBox(height: 10),
              textfield('Enter Menu Title'),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Menu Description",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
                maxLines: 6,
              ),
              SizedBox(height: 10),
              textfield('Menu Price'),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (builder) => Home()));
                    },
                    child: Text(
                      'Add',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(300, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      primary: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  textfield(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: name,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}

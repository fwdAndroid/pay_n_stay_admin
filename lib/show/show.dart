import 'package:flutter/material.dart';

class ProductOverview extends StatefulWidget {
  String? price;
  String? title;
  String? imageUrl;
  String? description;
  String? cetagory;
  String? type;
  ProductOverview(
      {Key? key,
      this.title,
      this.type,
      this.cetagory,
      this.imageUrl,
      this.description,
      this.price})
      : super(key: key);

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  Widget bottomNavbar({iconColor, backgroundColor, color, title, iconsData}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Icon(
              iconsData,
              size: 17,
              color: iconColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 14, color: color, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Product Overview',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Column(
            children: [
              ListTile(
                title: Text(
                  widget.type! +
                      " " +
                      widget.cetagory! +
                      ' laptop Category Title',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                subtitle: Text(
                  widget.title! + ' Product Name',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 250,
            child: Image.network(widget.imageUrl!, fit: BoxFit.cover),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Product Description',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Product Price ' + widget.price! + ' \$',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.description!,
              style: TextStyle(
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,

                  fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

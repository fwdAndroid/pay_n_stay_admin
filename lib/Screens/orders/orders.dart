import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pay_n_stay_admin/Screens/orders/current_orders.dart';
import 'package:pay_n_stay_admin/Screens/orders/previousorders.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            labelStyle: TextStyle(color: Colors.black),
            tabs: [
              Tab(
                text: "Current Orders",
              ),
              Tab(
                text: "Previous Orders",
              ),
            ],
          ),
          title: const Text(
            'Orders',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: TabBarView(
          children: [
            CurrentCurrentCurrentOrders(),
            PreviousOrders(),
          ],
        ),
      ),
    );
  }
}

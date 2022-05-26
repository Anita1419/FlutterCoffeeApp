import 'package:coffeeorders_app/models/coffeeOrder.dart';
import 'package:coffeeorders_app/screens/home/coffeetile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoffeeList extends StatefulWidget {


  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    //cycle through coffeeOrders
    final coffeeOrders = Provider.of<List<CoffeeOrder>>(context);
   // print(coffeeOrders.docs);
    return ListView.builder(
        itemCount: coffeeOrders.length,
        itemBuilder: (context,index) {
          return CoffeeTile(coffeeOrder: coffeeOrders[index]);
        }
        );
  }
}



import 'package:coffeeorders_app/models/CustomModelUser.dart';
import 'package:coffeeorders_app/screens/authenicate/authenticate.dart';
import 'package:coffeeorders_app/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomModelUser?>(context);
    print(user);
    if(user == null){
      return Authenticate();
    }else {
      return Home();
    }

  }
}

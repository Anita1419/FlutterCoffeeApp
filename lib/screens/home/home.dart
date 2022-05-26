import 'package:coffeeorders_app/models/coffeeOrder.dart';
import 'package:coffeeorders_app/screens/home/brewlist.dart';
import 'package:coffeeorders_app/screens/home/settings_form.dart';
import 'package:coffeeorders_app/services/auth.dart';
import 'package:coffeeorders_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    //show bottom sheet
    void _showSettingsPanel () {
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }


    return StreamProvider<List<CoffeeOrder>>.value(
      value: DatabaseService(_auth.currentUser!.uid.toString()).coffeeOrders,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Here'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text(''),
              onPressed: () => {_showSettingsPanel()},
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),

            child: CoffeeList()),
      ),
    );
  }
}

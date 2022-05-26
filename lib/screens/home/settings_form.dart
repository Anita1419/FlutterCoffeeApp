import 'dart:ffi';

import 'package:coffeeorders_app/models/CustomModelUser.dart';
import 'package:coffeeorders_app/services/Constants.dart';
import 'package:coffeeorders_app/services/database.dart';
import 'package:coffeeorders_app/services/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String? _currentName ;
  String? _currentSugars ;
  int? _currentStrength  ;
  //String _currentDefaultSugar = "0";



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomModelUser?>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(user!.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;
          return Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Update your Order Settings",
                          style: TextStyle(fontSize: 18.0
                          ,color: Colors.brown[900],
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: boxfielddecoration.copyWith(color: Colors.white),
                          child: TextFormField(
                            decoration: customdecoration.copyWith(hintText: "Enter your name"),
                            validator: (val) => val!.isEmpty ? "Please enter a name":null,
                            onChanged: (val) => setState(() {
                              _currentName = val;
                            }),
                            initialValue: userData!.name,
                          ),
                        ),
                        SizedBox(height: 40.0),
                        //Drop down menu
                        Container(
                          decoration: boxfielddecoration,
                          child: DropdownButtonFormField(
                            decoration: customdecoration,
                            value: _currentSugars ?? userData.sugars ,
                              items: sugars.map((sugar) {
                                return DropdownMenuItem(
                                  value: sugar,
                                    child: Text("$sugar Sugars",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                );
                              }).toList(),
                               onChanged: (val) {
                               setState(() {
                                 _currentSugars= val.toString();
                               });
                               },
                          ),
                        ),
                        //slider
                        Slider(
                          value:(_currentStrength ?? userData.strength).toDouble(),
                          activeColor: Colors.brown[_currentStrength ?? userData.strength],
                          inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                          min: 100.0,
                          max: 900.0,
                          //divisions
                          divisions: 8,
                          onChanged: (val){
                            setState(() {
                              _currentStrength = val.round();
                            });
                          },
                        ),

                        RaisedButton(
                          color: Colors.brown[900],
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              await DatabaseService(user.uid)
                              .updateUserData(
                                  _currentSugars ?? userData.sugars,
                                  _currentName ?? userData.name,
                                  _currentStrength ?? userData.strength
                              );
                              Navigator.pop(context);
                            }
                          },
                        )
                      ],
                    ),
                  );
        } else {
          return Loading();
        }
      }
    );
  }
}

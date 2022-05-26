import 'package:coffeeorders_app/services/Constants.dart';
import 'package:coffeeorders_app/services/auth.dart';
import 'package:coffeeorders_app/services/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign Up to Brew Crew'),
              actions: [
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.assignment_ind),
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: boxfielddecoration,
                      child: TextFormField(
                        decoration: customdecoration.copyWith(hintText: "Name"),
                        validator: (val) => val!.isEmpty ? "Enter Name " : null,
                        onChanged: (val) {
                          setState(() {
                            print(val);
                            name = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //previous one
                    Container(
                      decoration: boxfielddecoration,
                      child: TextFormField(
                        decoration:
                            customdecoration.copyWith(hintText: "Email"),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: boxfielddecoration,
                      child: TextFormField(
                        decoration:
                            customdecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                        validator: (val) => val!.length < 6
                            ? 'Enter an 6 + chars password'
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.registerWithEmailAndPassword(
                                  email.trim(), password);
                          print(email);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = "Error Ocuured";
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.brown[400],
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      error,
                      style: errorstyle,
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

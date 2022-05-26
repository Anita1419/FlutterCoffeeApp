import 'package:coffeeorders_app/services/Constants.dart';
import 'package:coffeeorders_app/services/auth.dart';
import 'package:coffeeorders_app/services/loading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;


  //text value fields
  String email = '';
  String password = '';
  String error ='';


  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: [
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          },
              icon: Icon(Icons.assignment_ind),
              label: Text("Sign Up"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),

              Container(
                  decoration: boxfielddecoration,
                child: TextFormField(
                  decoration: customdecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty ? "Please fill the email field" : null,
                  onChanged: (val) {
                    setState(() {
                      email = val.trim();
                    });
                  },
                ),
              ),

              SizedBox(height: 40.0,),
              Container(
                decoration: boxfielddecoration,
                child: TextFormField(
                  decoration: customdecoration.copyWith(hintText: "Password"),
                  validator: (val) => val!.isEmpty ? "Please fill the password Field" : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val.trim();
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              RaisedButton(onPressed: ()  async {
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result = await _authService.SignInWithEmailAndPassword(email.trim(), password);
                  if (result==null){
                    setState(() {
                      loading = false;
                      error = "ErrorOcurred!! InValid Email And Password";
                    });

                  }
                }

                print("Email is $email Password is $password");
              },
              child: Text("Sign In",
                style: TextStyle(color: Colors.white,),),
                color: Colors.brown[400],
              ),
              SizedBox(height: 12.0,),
              Text(error , style: errorstyle,)
              ],
          ),

        ),
        ),
    );
  }
}

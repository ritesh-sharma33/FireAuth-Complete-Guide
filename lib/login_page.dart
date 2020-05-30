
import 'package:fireauth/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireauth/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController, pwdController, nameController;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final AuthProviders authProviders = AuthProviders();

  @override
  void initState() {
    emailController = new TextEditingController();
    pwdController = new TextEditingController();
    nameController = new TextEditingController();
    super.initState();
  }

  void signIn(String email, String password, BuildContext context) async {
    FirebaseUser user;
    try {
      user = (await auth.signInWithEmailAndPassword(email: email, password: password)).user;
    } catch(e) {
      print(e);
    } finally {
      if (user != null) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomeApp(user.email)
        ));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Login Unsuccessful, try again!!!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (context) => Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 70),
                Hero(
                  tag: 'logo',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/flutter_1.png",
                        height: deviceHeight * 0.20,
                        width: deviceHeight * 0.20
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.black,
                        size: deviceHeight * 0.15
                      ),
                      Image.asset(
                        "assets/firebase_logo.png",
                        height: deviceHeight * 0.20,
                        width: deviceHeight * 0.20
                      )
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SafeArea(
                          child: Center(
                              child: Container(
                                  width: deviceWidth * 0.80,
                                  child: TextFormField(
                                    controller: emailController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter email';
                                      }

                                      var email = value;
                                      bool emailValid = RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(email);
                                      if (!emailValid)
                                        return "Enter valid email address";
                                      return null;
                                    },
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter email here...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  )))),
                      SafeArea(
                          child: Center(
                              child: Container(
                                  width: deviceWidth * 0.80,
                                  child: TextField(
                                    autocorrect: true,
                                    obscureText: true,
                                    controller: pwdController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter password here...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: Colors.white70,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        borderSide:
                                            BorderSide(color: Colors.red),
                                      ),
                                    ),
                                  )))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  width: 300,
                  child: RaisedButton(
                    elevation: 0,
                    color: Colors.orangeAccent,
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Colors.orangeAccent)),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data...')));

                        signIn(
                            emailController.text, pwdController.text, context);
                      } else {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Enter valid data!!!')));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Image.asset(
                        "assets/google_logo.png",
                        height: 40,
                        width: 40,
                      ),
                      onTap: () {
                        authProviders.handleGoogleSignIn().then((userEmail) {
                          if (userEmail != null) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeApp(userEmail)));
                          } else {
                            Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Something went wrong, please try again!!!')));
                          }

                        });
                      },
                    ),
                    InkWell(
                      child: Image.asset(
                        "assets/facebook_logo.png",
                        height: 40,
                        width: 40,
                      ),
                      onTap: () {},
                    ),
                    InkWell(
                      child: Image.asset(
                        "assets/twitter_logo.png",
                        height: 40,
                        width: 40,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
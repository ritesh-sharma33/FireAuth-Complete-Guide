import 'package:fireauth/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController, pwdController, nameController;
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    emailController = new TextEditingController();
    pwdController = new TextEditingController();
    nameController = new TextEditingController();
    super.initState();
  }

  void signUp(String email, String password, context) async {
    FirebaseUser user;
    try {
      user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      print(e);
    } finally {
      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeApp(nameController.text)));
      } else {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('SignUp Unsuccessful, try again!!!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (context) => Container(
            child: Column(
              children: <Widget>[
                SizedBox(),
                Hero(
                  tag: 'logo',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/flutter_1.png",
                        height: 175,
                        width: 175,
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 50,
                      ),
                      Image.asset(
                        "assets/firebase_logo.png",
                        height: 175,
                        width: 175,
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
                                  width: 360,
                                  child: TextFormField(
                                    controller: nameController,
                                    autofocus: true,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter name here...',
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
                                  width: 360,
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
                                  width: 360,
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

                        signUp(
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
                      onTap: () {},
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

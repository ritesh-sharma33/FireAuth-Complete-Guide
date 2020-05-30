import 'package:fireauth/login_page.dart';
import 'package:fireauth/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Hero(
              tag: 'logo',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/flutter_1.png",
                    height: 125,
                    width: 125,
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 50,
                  ),
                  Image.asset(
                    "assets/firebase_logo.png",
                    height: 125,
                    width: 125,
                  )
                ],
              ),
            ),
            SizedBox(height: 100,),
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                elevation: 0,
                color: Colors.blue,
                child: Text("Login", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.blue)),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LoginPage()
                    )
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                elevation: 0,
                color: Colors.red,
                child: Text("Register", style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => RegisterPage()
                    )
                  );
                },
              ),
            ),
            SizedBox(height: 120,),
            Text("© Copyright 2020, Coding Galaxy")
          ],
        ),
      ),
    );
  }
}

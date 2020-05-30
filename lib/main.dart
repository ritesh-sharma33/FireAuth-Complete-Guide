
import 'package:fireauth/auth_page.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage()
    );
  }
}
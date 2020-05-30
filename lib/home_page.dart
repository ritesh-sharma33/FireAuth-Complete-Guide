import 'package:flutter/material.dart';

class HomeApp extends StatefulWidget {

  final String userName;
  HomeApp(this.userName);

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Hi ${widget.userName}"
        ),
      ),
    );
  }
}
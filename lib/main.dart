import 'package:flipr/screens/login.dart';
import 'package:flipr/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helper/shared_pref_manager.dart';
SharedPrefManager sharedData = SharedPrefManager();
void main() {
  runApp( MyApp());
}
void setSharedPreferences() async {
  await sharedData.init();
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {

  bool user = false;
  @override
  void initState() {
    super.initState();
    _initCheck();
  }

  void _initCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('user') != null) {
      setState(() {
        user = prefs.getBool('user')!;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Splash(user),
    );
  }
}


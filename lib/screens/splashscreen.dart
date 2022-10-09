import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../helper/shared_pref_manager.dart';
import 'homepage.dart';
import 'login.dart';


class Splash extends StatefulWidget {
  final bool user;

  Splash(this.user);

  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? finalemail;
  SharedPrefManager sharedData = SharedPrefManager();

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  Future getValidationData() async {
    WidgetsFlutterBinding.ensureInitialized();
    await sharedData.init();
    var email = await sharedData.getEmail();
    setState(() {
      finalemail = email;
    });
  }

  startSplashScreen() {
    getValidationData();
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (c) => finalemail == null ? const LoginPage() : HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(
                flex: 2,
                child: Image(image: AssetImage('images/logo.png')),
              ),

            ],
          ),
        ],
      ),
    );
  }
}

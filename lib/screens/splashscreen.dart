import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../helper/piechart_employee.dart';

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
    print('email $email');
    setState(() {
      finalemail = email;
    });
  }

  startSplashScreen() {
    getValidationData();
    print('femail $finalemail');
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.cyan,Colors.blue],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(
                height: 150,
                // child: Image.asset('images/icon.png')
              ),

           Text("WELCOME",style: TextStyle(color:Colors.white,fontSize: 50,
               fontWeight: FontWeight.bold,fontFamily: 'RobotoMono'),),

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

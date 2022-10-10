import 'package:flipr/helper/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../screens/login.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String appName = '';
  String version = '';
  SharedPrefManager sharedData = SharedPrefManager();
  String user = '';

  @override
  initState() {
    super.initState();
    getAppData();
  }

  void getAppData() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) async {
      setState(() {
        appName = packageInfo.appName;
        version = packageInfo.version;
      });
    });
  }

  Future<void> logout() async {
    user = sharedData.getUserInfo();
    sharedData.setLogin(true);
    sharedData.removeMob();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text(user),
            accountName: Text(
              appName,
              style: const TextStyle(fontSize: 24.0),
            ),
            decoration: const BoxDecoration(
              color: Colors.teal,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 14),
            child: Text(
              'Version number:$version',
            ),
          ),
          Container(
            color: Colors.teal,
            padding: const EdgeInsets.all(14.0),
            child: Center(
              child: InkWell(
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  textAlign: TextAlign.left,
                ),
                onTap: logout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

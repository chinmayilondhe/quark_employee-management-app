import 'package:flipr/screens/employee_dashboard.dart';
import 'package:flutter/material.dart';
import '../helper/shared_pref_manager.dart';
import 'admin_dashboard.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPrefManager sharedData = SharedPrefManager();
  int? role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRoleStatus();
  }

  void getRoleStatus() async {
    var roleval = await sharedData.getRole();
    print(roleval);
    setState(() {
      role = roleval;
    });
    decideRole(role!);
  }

  void decideRole(int role) {
    if (role == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (c) => Employee()),
      );
    } else if (role == 1) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (c) => Admin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(Text: ),
      body: Padding(
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

import 'package:flipr/helper/shared_pref_manager.dart';
import 'package:flutter/material.dart';

import '../helper/piechart.dart';

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  SharedPrefManager sharedData = SharedPrefManager();
  var emp_id;
  void getRoleStatus() async {
   emp_id = await sharedData.getEmpID();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Container(
        child: PieChartGraph(),
      ),
    );
  }
}

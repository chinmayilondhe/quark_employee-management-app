import 'package:flutter/material.dart';

import '../helper/customdrawer.dart';
import '../helper/piechart.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee'),),
      drawer: const CustomDrawer(),
      body: Container(
        child: PieChartGraph(),
      ),
    );
  }
}

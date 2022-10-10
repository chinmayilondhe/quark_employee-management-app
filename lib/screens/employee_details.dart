import 'package:flutter/material.dart';

import '../helper/customdrawer.dart';
import '../helper/display_task_admin.dart';
import '../helper/display_task_employee.dart';
import '../helper/piechart_adminside.dart';
import '../helper/piechart_employee.dart';

class EmployeeDetails extends StatefulWidget {
  final String ID;
  // const EmployeeDetails({super.key});
  const EmployeeDetails({Key? key, required this.ID}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Employee'),
    ),
    drawer: CustomDrawer(),
    body: Container(
    height: 700,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    SizedBox(
    height: MediaQuery.of(context).size.height * 15 / 40,
    width: double.infinity,
    child: PieChartGraphAdmin(empID: widget.ID,)),

    // PieChartGraph(),
    SizedBox(
    height: 10,
    ),
    SizedBox(
    height: MediaQuery.of(context).size.height * 20 / 40,
    width: double.infinity,
    child:  DisplayTaskAdmin(empID: widget.ID),)

    ],
    ),
    ),);
  }
}


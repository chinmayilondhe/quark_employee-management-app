import 'package:flutter/material.dart';
import '../helper/customdrawer.dart';
import '../helper/display_task_employee.dart';
import '../helper/piechart_employee.dart';

import 'add_task.dart';

class Employee extends StatefulWidget {
  const Employee({Key? key}) : super(key: key);

  @override
  _EmployeeState createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee'),
      ),
      drawer: const CustomDrawer(),
      body: Container(
        height: 700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height * 15 / 40,
                width: double.infinity,
                child: PieChartGraph()),

            // PieChartGraph(),
            SizedBox(
              height: 10,
            ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 20 / 40,
        width: double.infinity,
      child:  DisplayTask(),)

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Task()));
          },
          icon: Icon(Icons.add),
          label: Text("Add New Task")
          // label: Text("Add Task")),
          ),
    );
  }
}

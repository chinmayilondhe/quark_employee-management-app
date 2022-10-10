import 'dart:convert';

import 'package:flipr/screens/add_employee.dart';
import 'package:flipr/screens/employee_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  getEmployee() async {
    var response = await http.get(
        Uri.https('omkar3602-flipr-backend.herokuapp.com', 'employee/list'));

    var jsonData = jsonDecode(response.body);
    List<EmployeeData> employee = [];
    for (var u in jsonData) {
      EmployeeData e = EmployeeData(u['name'], u['department'], u['_id']);
      if (u['role'] == "emp") {
        employee.add(e);
      }
    }

    print(employee.length);
    return employee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
      ),
      body: Container(
        child: Card(
            child: FutureBuilder(
                future: getEmployee(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text("Loading"),
                      ),
                    );
                  } else {
                    // var l= snapshot.data?.length;
                    // var length;
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data[i].name),
                                      Text(snapshot.data[i].department)
                                    ],
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        print(snapshot.data[i].id);
                                      },
                                      child: Text("See Details"))
                                ]),
                          ),
                        );
                      },
                    );
                  }
                })),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddEmployee()));
          },
          icon: Icon(Icons.add),
          label: Text("Add New Employee")),
    );
  }
}

class EmployeeData {
  final String name, department, id;

  EmployeeData(this.name, this.department, this.id);
}

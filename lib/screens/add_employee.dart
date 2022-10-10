import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../helper/api_model.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController _employeeName = TextEditingController();
  TextEditingController _employeeEmail = TextEditingController();
  TextEditingController _employeeNumber = TextEditingController();
  TextEditingController _employeeDepartment = TextEditingController();
  TextEditingController _employeePassword = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Add New Employee",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _employeeName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Employee Name',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _employeeEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _employeeNumber,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contact Number',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _employeeDepartment,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Department',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: 340,
                    child: TextField(
                      controller:
                          dateinput, //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Joining Date" //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1990), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          // print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          // print(formattedDate);

                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  )),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _employeePassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    // print(_employeeName.text);
                    // print(_employeeEmail.text);
                    // print(_employeeNumber.text);
                    // print(_employeeDepartment.text);
                    // print(dateinput.text);
                    addNewEmployee();
                  },
                  child: Text("Add Employee"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Api apiCall = Api();
  Future<void> addNewEmployee() async {
    // var taskData = await apiCall.addTask(selectedItem, _taskDescription.text,
    //     finalDateTime, _taskDuration.text, empId);
    var empData = await apiCall.addNewEmployee(
        _employeeName.text,
        _employeeEmail.text,
        _employeeNumber.text,
        _employeeDepartment.text,
        _employeeDepartment.text,
        dateinput.text,
        _employeePassword.text);

    if (empData["status"] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('New Employee Added Successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee not added\nTry again later')));
    }
  }
}

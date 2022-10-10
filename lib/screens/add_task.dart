import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api_model.dart';
import '../helper/shared_pref_manager.dart';

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  void initState() {
    super.initState();
    _loadEmpId();
  }

  List<String> items = ['Break', 'Meeting', 'Work'];
  String selectedItem = 'Work';
  String empId = '';
  String temp = '';
  TextEditingController _taskStart = TextEditingController();
  TextEditingController _taskDescription = TextEditingController();
  TextEditingController _taskDuration = TextEditingController();
  SharedPrefManager prefs = SharedPrefManager();
  _loadEmpId() async {
    temp = await prefs.getEmpID();
    setState(() {
      empId = temp;
    });
  }

  String date = DateFormat("MMMM, dd, yyyy").format(DateTime.now());
  String finalDateTime = "";
  @override
  // DateTime date= now.getDateOnly();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add task here"),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: DropdownButton(
                    value: selectedItem,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedItem = newValue!;
                      });
                    },
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
                    controller: _taskDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
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
                    // controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Time',
                    ),
                    controller: _taskStart,
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime != null) {
                        String formattedTime = pickedTime.format(context);

                        setState(() {
                          _taskStart.text =
                              formattedTime; //set the value of text field.
                          finalDateTime = date + " " + formattedTime;
                        });
                      }
                    },
                    // keyboardType: TextInputType.text,
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
                    controller: _taskDuration,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Duration',
                    ),
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(child: Text("Please add duration in minutes")),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    addNewTask();
                  },
                  child: Text("Add task"),
                ),
              )
            ]),
      ),
    );
  }

  Api apiCall = Api();
  Future<void> addNewTask() async {
    var taskData = await apiCall.addTask(selectedItem, _taskDescription.text,
        finalDateTime, _taskDuration.text, empId);
    if (taskData["status"] == "ok") {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task Added Successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task not added\nTry again later')));
    }
  }
}

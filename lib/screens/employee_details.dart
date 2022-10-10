import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EmployeeDetails extends StatefulWidget {
  final String ID;
  // const EmployeeDetails({super.key});
  const EmployeeDetails({Key? key, required this.ID}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  var str;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      str = '/task/emp/' + widget.ID;
    });
    print(str);
  }

  var ipAddress = "https://omkar3602-flipr-backend.herokuapp.com";
  // final str = "/task/emp" + widget.ID;
  getUser() async {
    // var response =
    //     await http.get(Uri.https('omkar3602-flipr-backend.herokuapp.com', str));
    var response = http.Request('GET', Uri.parse('$ipAddress$str'));
    var jsonData = jsonDecode(response.body);
    List<User> user = [];
    for (var u in jsonData) {
      User e = User(u['type'], u['description'], u['time_taken']);
      user.add(e);
    }

    print(user.length);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // for pi chart
          // Container(
          //   height: 50,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       getUser();
          //     },
          //     child: Text("Click here"),
          //   ),
          // ),
          // for task description
          Container(
            height: 500,
            child: Card(
                child: FutureBuilder(
                    future: getUser(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshot.data[i].type),
                                          Text(snapshot.data[i].description)
                                        ],
                                      ),
                                      // ElevatedButton(
                                      //     onPressed: () {
                                      //       print(snapshot.data[i].id);
                                      //       Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: ((context) =>
                                      //                   EmployeeDetails(
                                      //                       ID: snapshot
                                      //                           .data[i].id))));
                                      //     },
                                      //     child: Text("See Details"))
                                      Text(snapshot.data[i].timetaken)
                                    ]),
                              ),
                            );
                          },
                        );
                      }
                    })),
          )
        ]),
      ),
    );
  }
}

class User {
  final String type, description, timetaken;
  User(this.type, this.description, this.timetaken);
}

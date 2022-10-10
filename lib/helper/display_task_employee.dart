import 'package:flutter/material.dart';
import '../model/notification_model.dart';
import 'notification.dart';


int count = 0;
class DisplayTask extends StatefulWidget {
  const DisplayTask({Key? key}) : super(key: key);

  @override
  _DisplayTaskState createState() => _DisplayTaskState();
}

class _DisplayTaskState extends State<DisplayTask> {

  List<ApiModel> alerts = <ApiModel>[];
  List<ApiModel> alerts1 = <ApiModel>[];

  Future<bool> getalerts() async {
String empID=" ";
    Notification1 obj = Notification1();
    alerts1 = await obj.getNotifications(empID);
    alerts.addAll(alerts1);

    setState(() {
      count = alerts.length;
    });
    return true;
  }
  @override
  void initState() {
   getalerts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PreferredSize(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'All Notifications ',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
              ),

            ],
          ),
          preferredSize: const Size.fromHeight(30.0),
        ),
      ),
      body:

          ListView.builder(
              itemCount: alerts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Home(
                    description: alerts[index].description ?? "",
                    time: alerts[index].time ?? "",
                    type: alerts[index].type ?? "",
                  ),
                );
              }),
      // ),
    );
  }
}

class Home extends StatelessWidget {
  final String description;
  var time;
  var type;

  Home({
    required this.description,
    required this.time,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      color: Colors.grey[200],
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
        child: Column(
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Time Taken: $time mins',
              style: const TextStyle(fontSize: 15),
            ),
            Text(
              'Type of task: $type',
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/shared_pref_manager.dart';
import 'homepage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController ipAdd = TextEditingController();
  bool isLoading = false;
  String? url;
  SharedPrefManager sharedData = SharedPrefManager();
  getURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      url = prefs.getString('ServerURL');
    });
  }

  setURL(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ServerURL', url);
  }
  @override
  void initState() {
    getURL();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0, bottom: 50),
              child: Center(
                child: SizedBox(
                    width: 300,
                    height: 170,
                    // child: Image.asset('images/icon.png')
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: 350,
                child: TextFormField(
                  controller: mobileNoController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile Number',
                    hintText: 'Enter a 10-digit number',
                  ),
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  cursorRadius: const Radius.circular(15),
                  // inputFormatters: <TextInputFormatter>[
                  //   LengthLimitingTextInputFormatter(10),
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: SizedBox(
                width: 350,
                child: TextFormField(
                  controller: ipAdd..text = url ?? '',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Server URL',
                  ),
                  cursorRadius: const Radius.circular(15),
                ),
              ),
            ),
            isLoading ? const CircularProgressIndicator() : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 20),
              child: Container(
                height: 50,
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: BorderRadius.circular(15)),
                child: TextButton(
                  onPressed: () async {
                    setURL(ipAdd.text);
                    setState(() {
                      isLoading = true;
                    });
                    login();

                    // }
                  },
                  child: const Text('Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text('By signing in you agree to T&C and Privacy Policies')
          ],
        ),
      ),
    );
  }

String mobile = "";
// Api apiCall = Api();

Future<void> login() async {
  int mobilenum = int.tryParse(mobileNoController.text.toString()) ?? 0;

  if (mobileNoController.text.isNotEmpty ) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (c) => HomePage()),
    );
    sharedData.setIpAdd(ipAdd.text);

    // String devicetoken = await sharedData.getdeviceToken();
    // // bool status = await apiCall.login(mobilenum, devicetoken);
    // bool status=false;
    // if (status == true) {
    //   sharedData.setLogin(false);
    //   sharedData.setMobNo(mobileNoController.text);
    //   setState(() {
    //     isLoading = false;
    //   });
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (c) => HomePage()),
    //   );
    // } else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Invalid Mobile number')));
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Credentials are required')));
    setState(() {
      isLoading = false;
    });
  }
}
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/api_model.dart';
import '../helper/shared_pref_manager.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  SharedPrefManager sharedData = SharedPrefManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: const BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [Colors.lightBlueAccent, Colors.blue],
          //     begin: Alignment.bottomLeft,
          //     end: Alignment.topRight,
          //   ),
          // ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                    ),
                    keyboardType: TextInputType.text,
                    autofocus: true,
                    cursorRadius: const Radius.circular(15),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
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
                    onPressed: login,
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
              const Text(
                'By signing in you agree to T&C and Privacy Policies',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  String mobile = "";
  Api apiCall = Api();

  Future<void> login() async {
    String email_id = email.text;
    String password_text = password.text;
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      var loginData = await apiCall.login(email_id, password_text);
      String employee_id = loginData['_id'] ?? "";
      print(employee_id);
      int isAdmin = loginData['isAdmin'];
      String username = apiCall.getEmployeeInfo(employee_id);

      if (loginData["status"] == "ok") {
        sharedData.setLogin(false);
        sharedData.setEmail(email.text);
        sharedData.setEmpID(employee_id);
        sharedData.setRole(isAdmin);
        sharedData.setUsername(username);
        setState(() {
          isLoading = false;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (c) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid Email')));
        setState(() {
          isLoading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Credentials are required')));
      setState(() {
        isLoading = false;
      });
    }
  }
}

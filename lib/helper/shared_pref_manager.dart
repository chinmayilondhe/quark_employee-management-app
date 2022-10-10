import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  static SharedPreferences? prefs;

  Future<void> init() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
    await prefs?.reload();
  }

  dynamic _getStringSharedprefs(var key) async {
    var stringvalue = prefs?.getString("$key");
    return stringvalue;
  }

  dynamic _getBoolSharedprefs(var key) async {
    var boolvalue = prefs?.getBool("$key");
    return boolvalue;
  }

  dynamic _getIntSharedprefs(var key) async {
    var intval = prefs?.getInt("$key");
    return intval;
  }

  _setIntSharedprefs(var key, var value) async {
    prefs?.setInt("$key", value);
  }

  _setStringSharedprefs(var key, var value) async {
    prefs?.setString("$key", value);
  }

  _setBoolSharedprefs(var key, var value) async {
    prefs?.setBool("$key", value);
  }

  _removeval(var key) async {
    prefs?.remove('$key');
  }

  dynamic getEmpID() {
    var emp_id = _getStringSharedprefs('Emp_Id');
    return emp_id;
  }

  dynamic getEmail() async {

    String email = await _getStringSharedprefs('Email');

    return email;
  }

  dynamic getRole() async {

    int role = await _getIntSharedprefs('isAdmin')??0;

    return role;
  }

  dynamic getUserInfo() async {

    var user = await _getStringSharedprefs('User');

    return user;
  }

  dynamic getLogin() {
    var loginUser = _getBoolSharedprefs('login');
    return loginUser;
  }

  setEmpID(var emp_id) {
    _setStringSharedprefs('Emp_Id', emp_id);
  }

  setEmail(var email) {
    _setStringSharedprefs('Email', email);
  }

  setUsername(var username) {
    _setStringSharedprefs('User', username);
  }

  setLogin(var user) {
    _setBoolSharedprefs('login', user);
  }

  setRole(var flag) {
    _setIntSharedprefs('isAdmin', flag);
  }

  removeEmail() {

    _removeval('Email');
  }

}

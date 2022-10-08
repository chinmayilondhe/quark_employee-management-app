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

  dynamic _getStringListSharedprefs(var key) async {
    var stringListvalue = prefs?.getStringList("$key");
    return stringListvalue;
  }

  dynamic _getBoolSharedprefs(var key) async {
    var boolvalue = prefs?.getBool("$key");
    return boolvalue;
  }

  _setStringSharedprefs(var key, var value) async {
    prefs?.setString("$key", value);
  }

  _setStringListSharedprefs(var key, var value) async {
    prefs?.setStringList("$key", value);
  }

  _setBoolSharedprefs(var key, var value) async {
    prefs?.setBool("$key", value);
  }

  _removeval(var key) async {
    prefs?.remove('$key');
  }

  dynamic getIpAdd() {
    var ipAddress = _getStringSharedprefs('ipAdd');
    return ipAddress;
  }

  dynamic getMobNo() async {

    var mobNo;
    String mobNum = await _getStringSharedprefs('MobileNo') ?? "";
    try {
      mobNo = int.parse(mobNum);

    } on FormatException {
      print("Format Error!");
    }
    return mobNo;
  }

  dynamic getLogin() {
    var loginUser = _getBoolSharedprefs('login');
    return loginUser;
  }

  dynamic getAlertsFG() {
    var stringListfg = _getStringListSharedprefs('alertdatalistfg');
    return stringListfg;
  }

  dynamic getAlertsBG() {
    var stringListbg = _getStringListSharedprefs('alertdatalistbg');
    return stringListbg;
  }

  dynamic getdeviceToken() {
    var deviceToken = _getStringSharedprefs('deviceToken');

    return deviceToken;
  }

  setIpAdd(var ip) {
    _setStringSharedprefs('ipAdd', ip);
  }

  setMobNo(var mobnum) {
    _setStringSharedprefs('MobileNo', mobnum);
  }

  setLogin(var user) {
    _setBoolSharedprefs('login', user);
  }

  setAlertsFG(var fglist) {
    _setStringListSharedprefs('alertdatalistfg', fglist);
  }

  setAlertsBG(var bglist) {
    _setStringListSharedprefs('alertdatalistbg', bglist);
  }

  setDeviceToken(var devicetoken) {
    _setStringSharedprefs('deviceToken', devicetoken);

  }

  removeAlertfg() {
    _removeval('alertdatalistfg');
  }

  removeAlertbg() {
    _removeval('alertdatalistbg');
  }

  removeMob() {
    _removeval('MobileNo');
  }
}

import 'dart:convert';
import 'package:flipr/helper/shared_pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/response_body.dart';

SharedPrefManager shareddata = SharedPrefManager();

class Api {
  getPieChart(String emp_id) async {
    String endUrl = '/task/graph/' + emp_id;
    // getapiData['f'] = getFilterList();
    var pieChartData = await _performHttpRequest('GET', endUrl, {});
    var break_val = pieChartData['break'];
    var meet_val = pieChartData['meeting'];
    var work_Val = pieChartData['work'];
    ResponseBody responsedata = ResponseBody(
        break_val: break_val, meet_val: meet_val, work_Val: work_Val);
    return responsedata;
  }

  getEmployeeInfo(String emp_id) async {
    String endUrl = '/employee/' + emp_id;
    var pieChartData = await _performHttpRequest('GET', endUrl, {});
    return pieChartData['name'];
  }

  login(String email, String password) async {
    Map getapiData = {};
    getapiData['email'] = email;
    getapiData['password'] = password;
    var loginData =
        await _performHttpRequest('POST', '/employee/login', getapiData);
    print('data: $loginData');
    return loginData;
  }

  _performHttpRequest(String apiReq, String endUrl, Map getapidata) async {
    var ipAddress = "https://omkar3602-flipr-backend.herokuapp.com";

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(apiReq, Uri.parse('$ipAddress$endUrl'));
    request.body = json.encode(getapidata);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var datafinal = await response.stream.bytesToString();
      var data = jsonDecode(datafinal);
      return data;
    }
    return {};
  }
}

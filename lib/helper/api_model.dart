// import 'dart:convert';
// import 'package:flipr/helper/shared_pref_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// SharedPrefManager shareddata = SharedPrefManager();
// List originalList = [];
//
// List<String> getOriginalList() {
//   List<String> originalListOfString = [];
//   for (int i = 0; i < originalList.length; i++) {
//     originalListOfString.add(originalList[i].toString());
//   }
//   return originalListOfString;
// }
//
// class Api {
//   Future<dynamic> sendAcknowledgement(int mobnumber, List datalist) async {
//     Map getapiData = {};
//     getapiData['m'] = mobnumber;
//     getapiData['l'] = datalist;
//     var ackData =
//     await _performHttpRequest('POST', '/acknowledgement/', getapiData);
//     var status = ackData['s'];
//     return status;
//   }
//
//   Future<dynamic> getnotifications(int obtainedphone, int currentPage) async {
//     Map getapiData = {};
//     getapiData['m'] = obtainedphone;
//     getapiData['p'] = currentPage;
//
//
//     var notificationsData =
//     await _performHttpRequest('GET', '/notification/', getapiData);
//
//     List resultNotifications = notificationsData['l'];
//     originalList = notificationsData['d'];
//     bool status = notificationsData['s'];
//     ResponseBody responsedata = ResponseBody(
//         response: resultNotifications, status: status, timecolumn: false);
//     return responsedata;
//   }
//
//   getgraph(int mobilenum, var interval) async {
//     Map getapiData = {};
//     getapiData['m'] = mobilenum;
//     getapiData['i'] = interval;
//     // getapiData['f'] = getFilterList();
//     var graphData = await _performHttpRequest('GET', '/graph/', getapiData);
//     List resultseries = graphData['r'];
//     bool status = graphData['s'];
//     bool timecolumn = graphData['t'];
//     var maxyvalue = graphData['m'];
//
//     var intervalyaxis = graphData["i"];
//     // ResponseBody responsedata = ResponseBody(
//     //     response: resultseries,
//     //     status: status,
//     //     timecolumn: timecolumn,
//     //     maxy: maxyvalue,
//     //     interval: intervalyaxis);
//     // return responsedata;
//   }
//
//   login(int mobilenum, String devicetoken) async {
//     Map getapiData = {};
//     getapiData['a'] = mobilenum;
//     getapiData['b'] = devicetoken;
//     getapiData['t'] = "pushy";
//
//     var loginData = await _performHttpRequest('POST', '/login/', getapiData);
//     bool status = loginData['s'];
//     return status;
//   }
//
//   logOut(int mobilenum) async {
//     Map getapiData = {};
//     getapiData['a'] = mobilenum;
//     var logoutData = await _performHttpRequest('POST', '/logout/', getapiData);
//     bool status = logoutData['s'];
//     return status;
//   }
//
//   _performHttpRequest(String apiReq, String endUrl, Map getapidata) async {
//     var ipAddress = await shareddata.getIpAdd();
//     var headers = {'Content-Type': 'application/json'};
//     var request = http.Request(apiReq, Uri.parse('$ipAddress$endUrl'));
//     request.body = json.encode(getapidata);
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var datafinal = await response.stream.bytesToString();
//       var data = jsonDecode(datafinal);
//       return data;
//     } return {};
//   }
// }

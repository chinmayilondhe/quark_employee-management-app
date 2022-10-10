// import 'package:flutter/material.dart';
//
// import '../helper/api_model.dart';
// import '../helper/shared_pref_manager.dart';
// import '../model/response_body.dart';
//
// class PieData {
//   Api apiCall = Api();
//   SharedPrefManager sharedData = SharedPrefManager();
//   SharedPrefManager prefs = SharedPrefManager();
//   String temp="",empId="";
//
//   _loadEmpId() async {
//     temp = await prefs.getEmpID();
//     setState(() {
//       empId = temp;
//     });
//   }
//   Future<List<Data>> getData() async {
//     String emp_id ="";
//     emp_id=await sharedData.getEmpID();
//     print(emp_id);
//     var break_val, meet_val, work_val;
//     ResponseBody responseBody = await apiCall.getPieChart(emp_id);
//
//     break_val = double.parse(responseBody.break_val.toString());
//     meet_val = double.parse(responseBody.meet_val.toString());
//     work_val = double.parse(responseBody.work_Val.toString());
//     List<Data> data = [
//       Data('Break', break_val),
//       Data('Meeting', meet_val),
//       Data('Work', work_val),
//     ];
//     return data;
//   }
// }
//
// class Data {
//   final String task;
//   final double val;
//   Data(this.task, this.val);
// }
